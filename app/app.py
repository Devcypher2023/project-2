from flask import Flask, render_template, send_file, jsonify
import os
from io import BytesIO
from reportlab.lib.pagesizes import letter
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer
from reportlab.lib.styles import getSampleStyleSheet

app = Flask(__name__)

@app.route("/")
def home():
    return render_template("index.html")

@app.route("/health")
def health():
    return jsonify({"status": "healthy"}), 200

@app.route("/download-pdf")
def download_pdf():
    buffer = BytesIO()
    doc = SimpleDocTemplate(buffer, pagesize=letter)
    styles = getSampleStyleSheet()
    story = []

    story.append(Paragraph("John Doe", styles["Title"]))
    story.append(Paragraph("DevOps Engineer", styles["Heading2"]))
    story.append(Paragraph("john.doe@example.com", styles["Normal"]))
    story.append(Spacer(1, 12))

    story.append(Paragraph("Professional Summary", styles["Heading2"]))
    story.append(Paragraph(
        "DevOps Engineer experienced in AWS, Docker, Kubernetes, and CI/CD pipelines.",
        styles["Normal"]
    ))

    doc.build(story)
    buffer.seek(0)

    return send_file(buffer, as_attachment=True, download_name="resume.pdf", mimetype="application/pdf")

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(host="0.0.0.0", port=port)