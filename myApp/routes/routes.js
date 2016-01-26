var express = require('express'),
	router = express.Router(),
	userController = require('../Controllers/userController');
	
router.get('/', function(req, res, next){
	//
});
router.post('/signup', userController.signup);
router.post('/login', userController.login);
//WORK ON THIS
//router.get('/users/:username', userController.getUserData);
	
module.exports = router;

	