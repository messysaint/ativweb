package com.abrstech.obd2.util;



import java.math.BigDecimal;
import java.util.StringTokenizer;

public class OBD2JSON {

		/**
		 * @param args
		 */
		
		
		public static void main(String[] args) {
			// TODO Auto-generated method stub

			//double a = 10.0000012;
			//double b = 22.00;
			//Double c = new Double( 39.1);
			
			//System.out.println( format( a ) );
			//System.out.println( format( b ) );
			//System.out.println( format( c ) );
			
			
			String values = "-6.2200766 | -6.070458 | -5.880496 | -5.7086964 | -5.3148093 | -5.757131 | -4.632789 | -5.098611 | -5.478834 | -4.417328 | -4.0191574 | -5.0961623 | -4.6214814 | -6.0061674 | -6.2399364 | -4.972 | -5.616789 | -6.202018 | -5.9846053 | -6.328948 | -5.448767 | -6.079314 | -5.8989806 | -6.2168818 | -5.891648 | -5.5383997 | -5.706418 | -5.914931 | -4.7739244 | -5.325798 | -5.926429 | -5.2685575 | -5.54299 | -5.802763 | -4.9216676 | -4.856034 | -6.4633546 | -5.242758 | -6.2232356 | -6.986351 | -6.6238623 | -6.2843213 | -5.855384 | -5.3506975 | -6.097403 | -5.2801423 | -5.3159757 | -6.053274 | -6.008831 | -6.7060437 | -5.185064";
			
			OBD2JSON json = new OBD2JSON();
			//System.out.println( json.formatArrayJSON( values ) );
			
			float min = json.getMinValue( values );
			System.out.println( "Min: " + min );
			
			System.out.println( "Min Rounded: " + json.rounded( new BigDecimal(min) ) ); 
			
		}
		
		
		

		public String format(double d) {
				    if(d == (int) d)
		        return String.format("%d",(int)d);
		    else
		        return String.format("%s",d);
		}
		
		
		public String formatArrayJSON( String paramValue) {
			
			String rvalue = new String();
			
			StringTokenizer tokens = new StringTokenizer( paramValue, "|" );
			int tokenLength = tokens.countTokens();
			
			
			// construct
			// [0, 483994], [1, 479060], [2, 457648], [3, 401949], [4, 424705]
			rvalue += "[ ";
			for( int i = 0 ; i < tokenLength ; i++ ) {
				rvalue += "[";
				rvalue += i + "," + tokens.nextToken()  ;	
				rvalue += "]";
				if( i < (tokenLength-1) ) {
					rvalue += ", ";
				}
			}
			rvalue += " ]";
			
			return rvalue;
		}
		
		
		
		private static int DECIMAL = 2;
		private static int ROUNDING_MODE = BigDecimal.ROUND_HALF_EVEN;
		
		
		public BigDecimal rounded( BigDecimal big ) {
			return big.setScale( DECIMAL, ROUNDING_MODE );
		}
		
		
		public float getMinValue( String paramValue) {
			
			float min = 0.00F;
			Float tokenFloat = new Float( min );
			
			StringTokenizer tokens = new StringTokenizer( paramValue, "|" );
			int tokenLength = tokens.countTokens();
			
			
			for( int i = 0 ; i < tokenLength ; i++ ) {
				
				tokenFloat = new Float( tokens.nextToken() );
				
				if( i == 0) {
					min = tokenFloat.floatValue();
				}
					
				// compare
				if( tokenFloat.floatValue() < min ) {
					min = tokenFloat.floatValue();
				}
				
			}
						
			return min;
		}




	}
