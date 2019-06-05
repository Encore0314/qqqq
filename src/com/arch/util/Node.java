package com.arch.util;

import com.arch.basebean.*;

import java.util.*;

public class Node{
	    public Node(OracleRowSet ors){
	     try{
	       this.id=ors.getValue("functionid");
	       this.name=ors.getValue("functionname");
	       this.loadpage=ors.getValue("loadpage");
	       this.supid=ors.getValue("supid"); 
	       }
	       catch(Exception e){
	       }
	     }
	     private String id="";
	     private String name="";
	     private String loadpage="";
	     private String supid="";
	     
	     public String getId(){
	    	 return this.id;
	     }
	     public String getName(){
	    	 return this.name;
	     }
	     public String getLoadpage(){
	    	 return this.loadpage;
	     }
	     public String getSupid(){
	    	 return this.supid;
	     }	     	     
}

