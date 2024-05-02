const swaggerAutogen = require('swagger-autogen')()

const outputFile = './doc/swagger_output.json'
const endpointsFiles = ['./ex.js']

swaggerAutogen(outputFile, endpointsFiles)
