# -*- coding: future_fstrings -*-
from __future__ import print_function
import sys
from flask import Flask, request

app = Flask(__name__)

@app.route('/hello')
def helloIndex():
    return 'Hello World from Python Flask!'

import subprocess
from subprocess import Popen, PIPE
from subprocess import check_output


app = Flask(__name__)


@app.route('/',methods=['GET',])
def home():
    return f"""

        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="utf-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Welcome file</title>
            <link rel="stylesheet" href="https://stackedit.io/style.css" />
        </head>

        <body class="stackedit">
        <div class="stackedit__html">
            <h1 id="hello">Hello!</h1>
            <p>This is an admin application to manage your Akka project inside Kubernetes.</p>
            <h3 id="clone-repository">Clone repository</h3>
            <p>{request.base_url}clone/REPO_URL</p>
            <p>In case your repository is private, your url would look like this:</p>
            <pre><code>
            https://strafe:mygithubpassword@github.com/strafe/project.git
            </code></pre>
            <h3 id="sbt">run SBT commands</h3>
            <p>{request.base_url}sbt/kafkaProduce/DGR-COP-SUJETO-TRI/1/1000</p>
            <p>{request.base_url}sbt/kafkaProduce/DGR-COP-SUJETO-TRI/1000/150000</p>
            <p>{request.base_url}sbt/kafkaProduce/DGR-COP-ACTIVIDADES/1/1000</p>
        </div>
        </body>

        </html>"""

app.run(debug=True, host='0.0.0.0', port=5000)