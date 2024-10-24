const express = require("express");
const router = express.Router();
const userController = require("../controllers/user_controller");
const { verifyToken } = require("../config/auth");

// Rotas públicas
router.post("/auth/register", userController.register);
router.post("/auth/login", userController.login);

// Rota privada
router.get("/user/:id", verifyToken, async (req, res) => {
  const user = await User.findById(req.params.id, "-password");
  if (!user) return res.status(404).json({ msg: "Usuário não encontrado" });
  res.status(200).json(user);
});

module.exports = router;
