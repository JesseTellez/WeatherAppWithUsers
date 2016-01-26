var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var weatherSchema = new Schema({
	cityName: String,
	humidity: Number,
	temperature: Number,
	country: String,
	windSpeed: Number
});

weatherSchema.methods.updateWeather = function(temp, wind, humidity){
	this.temperature = temp;
	this.windSpeed = wind;
	this.humidity = humidity;	
	this.save(temp,wind,humidity);
};

mongoose.model('Weather', weatherSchema);
