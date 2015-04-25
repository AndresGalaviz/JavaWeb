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
public class Categoria {
    private int id;
    private String nombre;
    Categoria() {
        id = 0;
        nombre = "";
    }
    Categoria(int id, String nombre) {
        this.id = id;
        this.nombre = nombre;
    }
    public void setId(int id) {
        this.id = id;
    }
    public int getId() {
        return id;
    }
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    public String getNombre() {
        return nombre;
    }
}
