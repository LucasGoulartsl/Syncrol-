const bcrypt = require("bcrypt");
const User = require("../models/User");
const { generateToken } = require("../config/auth");

exports.register = async (req, res) => {
  const { name, email, password, confirmpassword } = req.body;

  // Validações
  if (!name) return res.status(422).json({ msg: "O nome é obrigatório" });
  if (!email) return res.status(422).json({ msg: "O email é obrigatório" });
  if (!password) return res.status(422).json({ msg: "A senha é obrigatória" });
  if (password !== confirmpassword) {
    return res.status(422).json({ msg: "As senhas não coincidem" });
  }

  // Checar se o usuário existe
  const userExist = await User.findOne({ email });
  if (userExist) {
    return res.status(422).json({ msg: "E-mail já registrado" });
  }

  // Criar senha
  const salt = await bcrypt.genSalt(12);
  const passwordHash = await bcrypt.hash(password, salt);

  // Criar usuário
  const user = new User({
    name,
    email,
    password: passwordHash,
  });

  try {
    await user.save();
    res.status(201).json({ msg: "Usuário criado com sucesso" });
  } catch (error) {
    res
      .status(500)
      .json({ msg: "Erro no servidor, tente novamente mais tarde" });
  }
};

exports.login = async (req, res) => {
  const { email, password } = req.body;

  // Validações básicas
  if (!email) return res.status(422).json({ msg: "O email é obrigatório" });
  if (!password) return res.status(422).json({ msg: "A senha é obrigatória" });

  try {
    // Checar se o usuário existe
    const user = await User.findOne({ email });
    if (!user) {
      return res.status(404).json({ 
        msg: "Usuário não encontrado", 
        code: "USER_NOT_FOUND" 
      });
    }

    // Verificar senha
    const checkPassword = await bcrypt.compare(password, user.password);
    if (!checkPassword) {
      return res.status(401).json({ 
        msg: "Senha inválida", 
        code: "INVALID_PASSWORD" 
      });
    }

    // Gerar token
    const token = generateToken(user);

    return res.status(200).json({ 
      msg: "Login realizado com sucesso", 
      token 
    });
  } catch (error) {
    console.error("Erro ao tentar logar:", error);
    return res.status(500).json({ 
      msg: "Erro no servidor, tente novamente mais tarde" 
    });
  }
};
