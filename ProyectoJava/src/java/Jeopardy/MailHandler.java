/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Jeopardy;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

/**
 *
 * @author Alberto
 */
public class MailHandler {
    public static void sendMail(String email, String username, String password) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
 
        Session session = Session.getInstance(props,
                new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication("jeopardydaw15@gmail.com", "jeopardy15");
                    }
                });
 
        String msgBody = "Hola " + username + ",\n\nGracias por registrate a Jeopardy. Tu password temporal es: " 
                + password + ".\nPuedes entrar con este password al sitio y cambiarlo por uno de tu eleccion.\n\nJeopardy Admin";
 
        try {
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress("admin@jeopardy.com", "jeopardy.com Admin"));
            msg.addRecipient(Message.RecipientType.TO, new InternetAddress(email, username));
            msg.setSubject("Your jeopardy.com account has been activated");
            msg.setText(msgBody);
            Transport.send(msg);
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}
