const express = require('express')
const app = express()
const port = 3000

const { exec } = require('child_process');

app.get('/', function (req, res) {
  exec('bin/001', (err, stdout, stderr) => {
    if (err) {
      return res.send(`${stderr}`);
    }
    return res.send(`${stdout}`);
  });
});

app.get('/aws', function (req,res) {
  exec('bin/002', (err, stdout, stderr) => {
    return res.send(`${stdout}`);
  });
});

app.get('/docker', function (req,res) {
  exec('bin/003', (err, stdout, stderr) => {
    return res.send(`${stdout}`);
  });
});

app.get('/loadbalanced', function (req,res) {
  exec('bin/004 ' + JSON.stringify(req.headers), (err, stdout, stderr) => {
    return res.send(`${stdout}`);
  });
});

app.get('/tls', function (req,res) {
  exec('bin/005 ' + JSON.stringify(req.headers), (err, stdout, stderr) => {
    return res.send(`${stdout}`);
  });
});

app.get('/secret_word', function (req,res) {
  exec('bin/006 ' + JSON.stringify(req.headers), (err, stdout, stderr) => {
    return res.send(`${stdout}`);
  });
});

app.listen(port, () => console.log(`Rearc quest listening on port ${port}!`))
