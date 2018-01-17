"use strict";

var express = require('express'),
    http = require('http'),
    redis = require('redis');

var app = express();

var client = redis.createClient('6379', 'redis-master');


app.get('/', function(req, res, next) {
    client.incr('counter', function(err, counter) {
        if(err) return next(err);
        console.log("counter is now: " + counter);
        res.set('Content-Type', 'text/html');
        res.send('<h2>This page has been viewed ' + counter + ' times!</h2>');
    });
});


app.get('/health', function(req, res, next) {
    res.set('Content-Type', 'text/html');
    res.send('OK');
});


app.get('/version', function(req, res, next) {
    res.set('Content-Type', 'text/html');
    res.send('1.0');
});


http.createServer(app).listen(process.env.PORT || 8080, function() {
    console.log('Listening on port ' + (process.env.PORT || 8080));
});