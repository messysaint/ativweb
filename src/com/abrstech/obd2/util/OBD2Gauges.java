package com.abrstech.obd2.util;



import java.math.BigDecimal;
import java.text.NumberFormat;
import java.util.StringTokenizer;

public class OBD2Gauges {

		/**
		 * @param args
		 */
		
		private static int DECIMAL = 2;
		private static int ROUNDING_MODE = BigDecimal.ROUND_HALF_EVEN;
		
		
		public static void main(String[] args) {
			// TODO Auto-generated method stub

			String values = "1.56 | 2.0887136 | 3.2170115 | -4.9305573";
			
			OBD2Gauges obd2 = new OBD2Gauges();
			
			obd2.parse( values );
			
			//NumberFormat nf = NumberFormat.getInstance();
			//nf.setMaximumFractionDigits(2);
			//nf.setMinimumFractionDigits(2);
			
			//System.out.println( "Min: " + nf.format( obd2.getMinValue() ) );
			//System.out.println( "Max: " + nf.format( obd2.getMaxValue() ) );
			//System.out.println( "Ave: " + nf.format( obd2.getAveValue() ) );
			
			
			float num = 10.000012343F;
			
			BigDecimal bd = new BigDecimal( num );
			
			System.out.println ( obd2.rounded( bd ) );
			
			
		}
		
		
		private Float totalValue = 0.00F;
		private Float tmpValue = 0.00F;
		private Float minValue = 0.00F;
		private Float maxValue = 0.00F;
		private Float aveValue = 0.00F;
		
		
		
		//System.out.println(nf.format(3.1415));
		
		public float getMinValue() {
					
			return minValue.floatValue();
		}
		
		
		public BigDecimal getBigDecimalMinValue() {
			
			BigDecimal bd = new BigDecimal( minValue.floatValue() );
			return rounded( bd );			
		}
		
		
		public float getMaxValue() {
			
			return maxValue.floatValue();
		}
		
				
		public BigDecimal getBigDecimalMaxValue() {
			
			BigDecimal bd = new BigDecimal( maxValue.floatValue() );
			return rounded( bd );			
		}

		
		public float getAveValue() {
			
			return aveValue.floatValue();
		}

		
		public BigDecimal getBigDecimalAveValue() {
			
			BigDecimal bd = new BigDecimal( aveValue.floatValue() );
			return rounded( bd );			
		}


		public String format( double d ) {
			
		    if(d == (int) d)
		        return String.format("%d",(int)d);
		    else
		        return String.format("%s",d);
		}

		
		public BigDecimal rounded( BigDecimal big ) {
			return big.setScale( DECIMAL, ROUNDING_MODE );
		}
		

		public int parse( String paramValue ) {
			
			int rvalue = 0;
			
			StringTokenizer tokens = new StringTokenizer( paramValue, "|" );
			int tokenLength = tokens.countTokens();
						
			for( int i = 0 ; i < tokenLength ; i++ ) {
				
				tmpValue =  Float.parseFloat( tokens.nextToken() );
				totalValue += tmpValue;
				
				System.out.println( i + " tmpValue: " + tmpValue );
				System.out.println( i + " TOTALValue: " + totalValue );
				
				if( i == 0 ) { // make first value the max and min
					maxValue = minValue = tmpValue;
				}
				
				if( tmpValue > maxValue ) { // save max 
					maxValue = tmpValue;
				}
				
				if( tmpValue < minValue ) { // save min
					minValue = tmpValue;
				}
			}	// end for
			
			aveValue = totalValue / tokenLength;
			
			return rvalue;
		}
		
	}
