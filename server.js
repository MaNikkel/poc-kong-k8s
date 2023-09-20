const express = require('express')
const jwt = require('jwt-simple')

const app = express()

app.get('/login', (req, res) => {
  const secret = 'supersecret'

  const payload = {
    iss: 'pocissuer',
    sub: 1,
    permissions: {
      booking: {
        hotdesk: true,
        meetingroom: true,
        privateoffice: false
      }
    }

  }

  const token = jwt.encode(payload, secret)

  res.json({ token })
})

app.get('/protected', (req, res) => {
  console.log(req.headers)

  const auth = req.headers.authorization.split(' ')[1]

  console.log(auth)

  // não precisamos validar o token pois o API gateway já faz isso, dessa forma os serviços não precisam da secret
    const decoded = jwt.decode(auth, '', true)

  console.log(decoded)

  return res.json({ message: 'protected' })
})

app.listen(80, () => {
  console.log('server running')
})