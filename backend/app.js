/* imports */
require('dotenv').config()
console.log("MONGODB_URI:", process.env.MONGODB_URI);
const express = require('express')
const mongoose = require('mongoose')
const bcrypt = require('bcrypt')
const jwt = require ('jsonwebtoken')
const cors = require ('cors');

const app = express()

//Config JSON Response
app.use(express.json())
app.use(cors());

//Models 
const User = require('./models/User')
const PORT = process.env.PORT || 3000;


//Open Route - Public Route
app.get ('/', (req, res)=> {
    res.status(200).json({msg: "Bem vindo"})
    
})

//Private Route 
app.get('/user/:id', checkToken, async (req, res) => {
    const id = req.params.id

    //checar se o usuário existe
    const user = await User.findById(id, '-password')

    if(!user) {
        return res.status(404).json({msg: "Usuário não encontrado"})
    }
    res.status(200).json({ user })
})

function checkToken(req, res, next){

    const authHeader = req.headers['authorization']
    const token = authHeader && authHeader.split (" ")[1]

    if(!token){
        return res.status(401).json({msg: "Acesso negado!"})
    }
    try {
        const secret = process.env.SECRET

        jwt.verify(token, secret)
        
        next()
    } catch(error){
        res.status(400).json({msg:"Token inválido" })
    }
}



//Registrar usuário 
app.post('/auth/register', async(req, res) => {

    const {name, email, password, confirmpassword} = req.body

    //Validações
    if(!name){
        return res.status(422).json({msg: "O nome é obrigatório"})
    }
    if(!email){
        return res.status(422).json({msg: "O email é obrigatório"})
    }
    if(!password){
        return res.status(422).json({msg: "A senha é obrigatória"})
    }
    if(password !== confirmpassword) {
        return res.status(422).json({msg: "As senhas não coincidem"})
    }

    //Checar se o usuário existe
    const userExist = await User.findOne({email: email})

    if(userExist){
        return res.status(422).json({msg: "E-mail já registrado"})
    }

    //Criar senha
    const salt = await bcrypt.genSalt(12)
    const passwordHash = await bcrypt.hash(password, salt)

    //Criar usuário
    const user = new User({
        name,
        email,
        password: passwordHash,
    })

    try {
        await user.save()
        res.status(201).json({msg: "Usuário criado com sucesso"})
    }  catch(error) {
        console.log(error)

        res.status(500).json({msg: "Ocorreu um erro no servidor, tente novamente mais tarde" })

    }
    
})

//Login 
app.post('/auth/login', async (req, res) => {
    const {email, password} = req.body

    //validações
    if(!email){
        return res.status(422).json({msg: "O email é obrigatório"})
    }
    if(!password){
        return res.status(422).json({msg: "A senha é obrigatória"})
    }

    //Checar se o usuário existe
    const user = await User.findOne({email: email})

    if(!user){
        return res.status(404).json({msg: "Usuário não encontrado"})
    }

    //Checar se a senha coincide
    const checkPassword = await bcrypt.compare(password, user.password)

    if(!checkPassword){
        return res.status(422).json({msg: "Senha inválida"})

    }



    try {

        const secret = process.env.SECRET

        const token = jwt.sign({
            id: user._id
        }, secret,)

        res.status(200).json({msg: "Login realizado com sucesso", token })

    } catch(err){

        res.status(500).json({
            msg: "Ocorreu um erro no servidor, tente novamente mais tarde",
        })


    }

})

//Credenciais
const dbUser = process.env.DB_USER
const dbPassword = process.env.DB_PASS

mongoose
.connect(process.env.MONGODB_URI).then(() => {
    app.listen(3000)
    console.log("Sucesso ao conectar ao banco de dados")
}).catch((err) => console.log(err))

