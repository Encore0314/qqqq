package com.arch.util;

import java.util.ArrayList;
import java.util.List;

import com.arch.basebean.OracleRowSet;

public class Tree {
    public Node[] getChildre(OracleRowSet[] aa,Node nd){
	       List<Node> r=new ArrayList<Node>();
	       try{
	       for(int i=0;i<aa.length;i++){
	          if(aa[i].getValue("supid").equals(nd.getId())){
	           r.add(new Node(aa[i]));
	          }
	       }
	       }
	       catch(Exception e){}
	       
	       return (Node[])r.toArray(new Node[r.size()]);
	     }
	    public String printNode(Node nd,OracleRowSet[] aa){
	    	  
	    	   String ni="{'property':{'name':'"+nd.getName()+"','url':'";
	    	   if(nd.getLoadpage().equals("")){
	    		   ni+="'}";
	    	   }else{
	    	   ni+=Azdg.encrypt("fid="+nd.getLoadpage(),SysConst.FORMACTION)+"'}";
	    	   }
	    	    Node[] child=getChildre(aa,nd);
	    	    if(child.length>0){
		    	  ni+=",'children':["; 	
		    	   for(int i=0;i<child.length;i++){
		    		     if(i>0){
			    	     ni+=","+printNode(child[i],aa);
		    		     }else{
		    		     ni+=printNode(child[i],aa);	 
		    		     }
			    	    }
                  ni+="]";
	    	    }
	    	   ni+="}";
	    	   return ni;
	    	 }
	     }


