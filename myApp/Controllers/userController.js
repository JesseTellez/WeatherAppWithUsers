var crypto = require('crypto'),
	mongoose = require('mongoose'),
	User = mongoose.model('User'),
	passport = require('passport'),
	jwt = require('express-jwt'),
	auth = jwt({secret: 'SECRET', userProperty: 'payload'});
	
exports.signup = function(req, res){
	//remember that username is required
	if (!req.body.username || !req.body.password) {
   	 	return res.status(400).json({message: 'Please fill out all fields'});
 	 }
    
	var newUser = new User();
    newUser.username = req.body.username;
    newUser.zip = req.body.zip;
    newUser.countryId = req.body.countryId;
    console.log(newUser);
	newUser.setPassword(req.body.password);
	newUser.save(function(err){
		if(err){
            res.session.err = err;
			return res.status(400).json({message: 'Something went Wrong'});
		}
		else{
            req.session.user = newUser.id;
            req.session.username = newUser.username;
            req.session.msg = 'Authenticated as ' + newUser.username;
			return res.json({token: newUser.generateJWT});
		}
	});
};

exports.login = function(req, res, next){
  if (!req.body.username || !req.body.password) {
    return res.status(400).json({message: 'Please fill out all fields'});
  }

  passport.authenticate('local', function(err, user, info) {
    if (err) { return (err); }

    if (user) {
      req.session.regenerate(function(){
          req.session.user = user.id;
          //console.log(req.session.user + "YEAH CUH");
          req.session.username = user.username;
          req.session.msg = 'Authenticated as ' + user.username;
      });
      return res.json({token: user.generateJWT()});
    } else {
      return res.status(401).json(info);
    }
  })(req, res, next);
};

exports.getUserData = function(req, res) {
    
    User.findOne({"username": req.body.username}, "username zip countryId", function(err, user){
        if (err){
            return (err);
        }
        if (user) {
            //return res.json(user.session.username);
            return res.json({username: req.session.username, zip: req.session.zip, country: req.session.countryId});
        }else {
            return res.status(400).json({message: "something went wrong again"});
        }
    });
}

exports.logOutUser = function(req, res) {
    User.findOne({"username": req.body.username}, function(err, user){
        if(user){
            req.session.destroy(function(err){
                console.log("this is our user" + user);
                if(!err){
                    return res.json({message: "Successfully ended session"});
                }
                else {
                    return (err);
                }
            })  
        }
        else {
            return res.status(400).json({message: "nope didnt work"});
        } 
    });
}

// exports.getUserProfile = function(req, res){
// 	User.findOne({_id: req.session.user}).exec(function(err, user){
// 		if(!user){
// 			res.json(404, {err: 'User not found'});
// 		}
// 		else{
// 			res.json(user);
// 		}	
// 	});
// };

// exports.updateUser = function(req, res){
// 	User.findOne({username: req.session.username}).exec(function(err, user){
// 		user.set('email', req.body.email);
// 		user.set('color', req.body.color);
// 		user.save(function(err){
// 			if(err){
// 				req.session.error = err;
// 			}
// 			else{
// 				req.session.msg = 'User Updated';
// 			}
// 			res.redirect('/user');
// 		});
// 	});
// };

// exports.deleteUser = function(req, res){
// 	User.findOne({_id: req.session.user}).exec(function(err, user){
// 		if(user){
// 			user.remove(function(err){
// 				if(err){
// 					req.session.msg = err;
// 				}
// 				req.session.destroy(function(){
// 					res.redirect('/login');
// 				});
// 			});
// 		}
// 		else{
// 			req.session.msg = 'User not found';
// 			req.session.destroy(function(){
// 				res.redirect('/login');
// 			});
// 		}
// 	});	
// };
