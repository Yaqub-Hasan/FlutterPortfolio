const express = require('express');       //import package
const bcryptjs = require('bcryptjs');
const jwt = require('jsonwebtoken');
const User = require("../models/user.js");
const auth = require("../MiddleWare/auth.js");

const authRouter = express.Router();

//SignUp route
authRouter.post("/api/authentication" , async (req , res) => {
   try{
   const {name , email , password} =  req.body;
      const existingUser = await User.findOne({email});
      if(existingUser){
      return res.status(400).json({msg: 'User with same email is already exists!'});
      }

      const hashedPassword =  await bcryptjs.hash(password , 8);

      let user = new User({
       email,
       password: hashedPassword,
       name,
      });

      user = await user.save();
      res.json(user);
   }catch(e){
    res.status(500).json({error: e.message});
   }
});

///SignIn Route:
authRouter.post("/api/signIn" , async(req , res) => {
 try{
   const {email , password} =  req.body;
   const user = await User.findOne({email});
   if(!user){
     return res.status(400).json({msg:"User with this email doesn't exist"});
   }

   const isMatch = bcryptjs.compare(password , user.password);
   if(!isMatch){
     return res.status(400).json({msg:"Incorrect password"});
   }

   const token = jwt.sign({id: user._id} , "passwordKey");
   res.json({token , ...user._doc});
 }catch(e){
    res.status(500).json({error: e.message});
 }
});

///
authRouter.post("/tokenIsValid" , async(req , res) => {
 try{
   const token = req.header("XToken");
   if(!token){
   return res.json(false);
   }
   const isVerified = jwt.verify(token,'passwordKey');
   if(!isVerified){
      return res.json(false);
   }

   const user = await User.findById(isVerified.id);
   if(!user){
   return res.json(false);
   }
   res.json(true);

 }catch(e){
    res.status(500).json({error: e.message});
 }
});


///get User Data
authRouter.get("/" , auth , async (req , res) => {
const user = await User.findById(req.user);
res.json({ ...user._doc, token: req.token });
});

module.exports = authRouter;