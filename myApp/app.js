var express = require('express');

const expressSession = require('express-session');
var path = require('path');
var logger = require('morgan');
const MongoStore = require('connect-mongo/es5')(expressSession);
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var mongoose = require('mongoose');
var passport = require('passport');

require('./models/user');
require('./config/passport');
//var routes = require('./routes/index');
//var users = require('./routes/users');
var routes = require('./routes/routes');
var users = require('./routes/users');
mongoose.connect('mongodb://localhost:27020/weatherApp');
var app = express();

//mongoose.connect('enter in the data base address here');

// view engine setup
//app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

// uncomment after placing your favicon in /public
//app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use(passport.initialize());
app.use(expressSession({
  secret: 'SECRET',
  cookie: {maxAge: 60*60*1000},
  store: new MongoStore({
      url: 'mongodb://localhost:27020/weatherApp',
      ttl: 14 * 24 * 60 * 60,
      collection: 'sessions'
    }),
  resave: true,
  saveUninitialized: true
}));
app.use('/', routes);
app.use('/users', users);

// app.use(expressSession({
//   secret: 'SECRET',
//   cookie: {maxAge: 60*60*1000},
//   store: new mongoStore({
//     db: mongoose.connection.db,
//     collection: 'sessions'
//   }) 
// }));

app.use(function(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
});

if (app.get('env') === 'development') {
  app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    res.render('error', {
      message: err.message,
      error: err
    });
  });
}

app.use(function(err, req, res, next) {
  res.status(err.status || 500);
  res.render('error', {
    message: err.message,
    error: {}
  });
});

module.exports = app;
//require('./routes')(app);
//app.listen(3000);
//Console.log("App listening on "+ app.listen(3000));

// app.use('/', routes);
// app.use('/users', users);

// catch 404 and forward to error handler
// app.use(function(req, res, next) {
//   var err = new Error('Not Found');
//   err.status = 404;
//   next(err);
// });

// // error handlers

// // development error handler
// // will print stacktrace
// if (app.get('env') === 'development') {
//   app.use(function(err, req, res, next) {
//     res.status(err.status || 500);
//     res.render('error', {
//       message: err.message,
//       error: err
//     });
//   });
// }

// production error handler
// no stacktraces leaked to user
// app.use(function(err, req, res, next) {
//   res.status(err.status || 500);
//   res.render('error', {
//     message: err.message,
//     error: {}
//   });
// });

//here is a example of how to use a model
//var User = require('./models/users');

// app.post('/api/users', function(req, res, next){
//    var user = new User({
//       username: req.body.username,
//       password: req.body.password,
//       hometown: req.body.hometown
//    })
//    user.save(function(err){
//      if(err) throw err;
//      res.json(201, user);
//    });
// });

// module.exports = app;
