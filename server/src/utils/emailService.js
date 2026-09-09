const nodemailer = require("nodemailer");

const emailUser = (process.env.EMAIL_USER || "").trim();
const emailPass = (process.env.EMAIL_PASS || "").replace(/\s+/g, "");

if (!emailUser || !emailPass) {
  console.warn(
    "Email configuration is missing. Please set EMAIL_USER and EMAIL_PASS in .env",
  );
}

const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: emailUser,
    pass: emailPass,
  },
});

async function sendMail(to, subject, text) {
  if (!emailUser || !emailPass) {
    throw new Error("EMAIL_USER and EMAIL_PASS must be configured in .env");
  }

  await transporter.sendMail({
    from: process.env.EMAIL_FROM,
    to,
    subject,
    text,
  });
}

module.exports = { sendMail };
