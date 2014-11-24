/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

import java.awt.Component;
import java.awt.Cursor;
import java.awt.Dimension;
import java.awt.Image;
import java.awt.Point;
import java.awt.Toolkit;
import javax.swing.JDialog;
import javax.swing.JFrame;

/**
 *
 * @author TESDA
 */
public class Graphics {
    public static void setToCenter(JFrame jf){
        Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();
        double width = screenSize.getWidth();
        double height = screenSize.getHeight();
        
        int x = (int)(width / 2)-(jf.getWidth()/2);
        int y = (int) (height / 2)-(jf.getHeight()/2);
        
        jf.setLocation(x, y);
    }
    public static void setToCenter(JFrame jf,JDialog dialog){
        double width = jf.getWidth();
        double height = jf.getHeight();
        
        int x = (int)(width / 2)-(dialog.getWidth()/2)+(jf.getX()/2);
        int y = (int) (height / 2)-(dialog.getHeight()/2);
        
        dialog.setBounds(x,y,360,330);
    }
    
    public static void setCursor(Component com,String cursor){
        Toolkit toolkit = Toolkit.getDefaultToolkit();
        Image cursorImage = toolkit.getImage("cursor.gif");
        Point cursorHotSpot = new Point(0,0);
        Cursor customCursor = toolkit.createCustomCursor(cursorImage, cursorHotSpot, "Cursor");
        com.setCursor(customCursor);
    }
}
