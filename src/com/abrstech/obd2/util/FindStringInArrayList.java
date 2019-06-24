package com.abrstech.obd2.util;

import java.util.ArrayList;

public class FindStringInArrayList {

	String[] arr = null;
	
	
	public void setArrayList( ArrayList a ) {
		
		arr = (String[]) a.toArray( new String[ a.size() ] );
	}
	
	
	public boolean equalsIgnoreCase( String s ) {
	
		boolean rvalue = false;
							
		for( int i = 0 ; i < arr.length ; i++ ) {
			
			if( arr[i].equalsIgnoreCase( s.trim() ) ) {
				rvalue = true;
				break;
			}
		}
		
		return rvalue;
		
	}
	
	
	public boolean equals( String s ) {
		
		boolean rvalue = false;
							
		for( int i = 0 ; i < arr.length ; i++ ) {
			
			if( arr[i].equals( s.trim() ) ) {
				rvalue = true;
				break;
			}
		}
		
		return rvalue;
		
	}
	
	
	public boolean contains( String s ) {
		
		boolean rvalue = false;
							
		for( int i = 0 ; i < arr.length ; i++ ) {
			
			if( arr[i].contains( s.trim() ) ) {
				rvalue = true;
				break;
			}
		}
		
		return rvalue;
		
	}


	public boolean containsByIndex( String s ) {
		
		boolean rvalue = false;
							
		for( int i = 0 ; i < arr.length ; i++ ) {
			
			if( arr[i].indexOf( s.trim() ) != -1 ) {
				rvalue = true;
				break;
			}
		}
		
		return rvalue;
		
	}

	
	

}
