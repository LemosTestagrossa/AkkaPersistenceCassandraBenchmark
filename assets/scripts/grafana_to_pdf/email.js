const nodemailer = require('nodemailer');
const markdown = require('nodemailer-markdown').markdown;
const path = require("path");


// Output file name should be passed as first parameter
const outfile = process.argv[2];

const transporter = nodemailer.createTransport({
    service: 'Gmail',
    auth: {
        user: 'miguelemosreverte@gmail.com',
        pass: 'osopanda'
    }
});
transporter.use('compile', markdown());

const mailOptions = {
    from: 'miguelemosreverte@gmail.com',
    to: 'miguelemosreverte@gmail.com',
    subject: 'Grafana',
    text: 'Contenido del email',
    markdown: '# Hello world!\n\nThis is a **markdown** message',
    attachments: [
        {
            filename: 'Grafana.pdf', // <= Here: made sure file name match
            path: path.join(__dirname, outfile), // <= Here
            contentType: 'application/pdf'
        }
    ]
};

transporter.sendMail(mailOptions, (error, info) => {
    if (error){
        console.log(error);
    } else {
        console.log("Email sent");
    }
});