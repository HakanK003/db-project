package com.cydeo.day1;


import java.sql.*;

/**
 * Your EC2 Server already contains a practice app called Spartan
 * It has oracle database with single table
 * You can also check out the UI
 * by navigating to URL  YourEC2ServerIP:8000
 * IP is the same as HR database
 * Username :
 * Password :
 *
 */

public class SpartanDB_Test {

    public static void main(String[] args) throws SQLException {

        String url = "jdbc:oracle:thin:@IP:1521:XE" ;
        String username = "" ;
        String password = "" ;

        Connection conn = DriverManager.getConnection(url,username,password) ;
        Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        ResultSet rs   = stmt.executeQuery("SELECT * FROM SPARTANS") ;

        // This table has SPARTAN_ID, NAME , GENDER , CREATED_AT , UPDATED_AT
        while( rs.next() ) {
            System.out.println(rs.getString("SPARTAN_ID") + " " + rs.getString("NAME"));
        }

    }


}