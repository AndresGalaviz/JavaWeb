/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Jeopardy;

/**
 *
 * @author Alberto
 */
public class Pregunta {
    private int id;
    private String pregunta, respuesta;
    Pregunta() {
        id = 0;
        pregunta = respuesta = "";
    }
    Pregunta(int id, String pregunta, String respuesta) {
        this.id = id;
        this.pregunta = pregunta;
        this.respuesta = respuesta;
    }
    public void setId(int id) {
        this.id = id;
    }
    public int getId() {
        return id;
    }
    public void setPregunta(String pregunta) {
        this.pregunta = pregunta;
    }
    public String getPregunta() {
        return pregunta;
    }
    public void setRespuesta(String respuesta) {
        this.respuesta = respuesta;
    }
    public String getRespuesta() {
        return respuesta;
    }
}
