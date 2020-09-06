# Process
# Environment: Set the Grafana server URL, username, and password, and the output filename as environment variables.

export GF_DASH_URL="http://0.0.0.0:3000/d/DGR-COP-SUJETO_TRI2/dgr-cop-sujeto_tri2?orgId=1&refresh=10s"
export GF_USER=admin
export GF_PASSWORD=admin
export OUTPUT_PDF=./output.pdf

# Export the Grafana dashboard to PDF
node grafana_pdf.js $GF_DASH_URL $GF_USER:$GF_PASSWORD $OUTPUT_PDF
# Send the PDF via email
node email.js $OUTPUT_PDF