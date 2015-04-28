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
public class Pregunta implements Comparable{
    private int id, puntos, idCategoria;
    private String pregunta, respuesta;
    Pregunta() {
        id = 0;
        pregunta = respuesta = "";
    }
    Pregunta(int id, String pregunta, String respuesta, int puntos, int idCategoria) {
        this.id = id;
        this.pregunta = pregunta;
        this.respuesta = respuesta;
        this.puntos = puntos;
        this.idCategoria = idCategoria;
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
    public void setPuntos(int puntos) {
        this.puntos = puntos;
    }
    public int getPuntos() {
        return puntos;
    }

    @Override
    public int compareTo(Object o) {
        Pregunta otro = (Pregunta)o;
 
        if ( puntos > otro.puntos) {
            return 1;
        } else if ( puntos < otro.puntos ) {
            return -1;
        }
        if ( idCategoria > otro.idCategoria) {
            return 1;
        } else if ( idCategoria < otro.idCategoria ) {
            return -1;
        }
        return 0;
    }
}
