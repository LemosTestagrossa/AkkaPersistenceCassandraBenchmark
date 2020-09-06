# Process
# Environment: Set the Grafana server URL, username, and password, and the output filename as environment variables.

# export GF_DASH_URL="http://0.0.0.0:3001/d/DGR-COP-SUJETO_TRI/dgr-cop-sujeto_tri?orgId=1&refresh=10s"
export GF_DASH_URL="https://github.com/miguelemosreverte"
export GF_USER=admin
export GF_PASSWORD=prom-operator
export OUTPUT_PDF=./output.pdf

# Export the Grafana dashboard to PDF
node grafana_pdf.js $GF_DASH_URL $GF_USER:$GF_PASSWORD $OUTPUT_PDF
# Send the PDF via email
node email.js $OUTPUT_PDF