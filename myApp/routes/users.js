var express = require('express');
var router = express.Router();
var mongoose = require('mongoose');
var User = mongoose.model('User');
var userController = require('../Controllers/userController');
/* GET users listing. */
router.get('/', function(req, res, next) {
  res.send('respond with a resource');
});

// router.param('username', function(req, res, id, next){
//     var query = User.findById(id);
    
//     query.exec(function(err, user){
//        if(err){return next(err);} 
//        if(!user) {
//            console.log("no user found");
//            return next(new Error('can \'find post'));
//        }
//        req.username = user;
//        console.log(user);
//        return next();
//     });
// });

router.get('/p/', function(req, res, next){
    console.log("Hello! " + req.query.username);
    User.findOne({"username": req.query.username}, "username zip countryId", function(err, user){
        if (err){
            return (err);
        }
        if (user) {
            return res.json(user)
            //return res.json({username: req.session.username, zip: req.session.zip, country: req.session.countryId});
            return res.json({username: user.username, zip: user.zip, country: user.countryId});
        }else {
            return res.status(400).json({message: "something went wrong again"});
        }
    });
});

router.post('/p/logout', userController.logOutUser);
module.exports = router;