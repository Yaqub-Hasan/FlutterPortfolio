//Import from other files:
const authRouter = require("./routes/auth.js");
const adminRouter = require("./routes/admin");
const productRouter = require("./routes/product");
const userRouter = require("./routes/user");

//API
const express = require('express');       //import package
const mongoose = require('mongoose');
const PORT = 3000;
const app = express();
const url = "mongodb+srv://yaqub:Syr12345@cluster0.cjkbh9r.mongodb.net/?retryWrites=true&w=majority";


//MiddleWare
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);



//connections:
mongoose.connect(url).then( () => {
  console.log("connection success");
}).catch((e)=>{
 console.log(e);
});




app.listen(PORT,"0.0.0.0" , () => {
console.log(`connected at port ${PORT} hello`);
});