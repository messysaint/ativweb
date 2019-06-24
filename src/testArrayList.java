import java.util.ArrayList;
import java.util.Iterator;

import com.abrstech.obd2.util.*;

public class testArrayList {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

		 ArrayList notifyParams = new ArrayList(); 
		
		 notifyParams.add( "Engine Load(%)" );
		 notifyParams.add( "Voltage (Control Module)(V)" );
		 notifyParams.add( "Fuel Level (From Engine ECU)(%)" );
		 notifyParams.add( "Engine Coolant Temperature(°F)" );
		 notifyParams.add( "Catalyst Temperature (Bank 1 Sensor 1)(°F)" );
		 notifyParams.add( "Distance to empty (Estimated)(miles)" );
		 notifyParams.add( "Torque(ft-lb)" );
		 notifyParams.add( "CO? in g/km (Average)(g/km)" );
		 
		 FindStringInArrayList find = new FindStringInArrayList();
		 find.setArrayList( notifyParams );

		 String s = "CO? in g/km (Average)(g/km)";
		 
		 
		 if( find.equalsIgnoreCase( s) ) { 
			 System.out.println( "eic YES Found > " + s );
		 } else {
			 System.out.println( "eic NOT Found > " + s );
		 }
		 
		 
		 
		 if( find.equals( s) ) {
			 System.out.println( "e YES Found > " + s );
		 } else {
			 System.out.println( "e NOT Found > " + s );
		 }
		 
		 
		 if( find.contains( s) ) {
			 System.out.println( "c YES Found > " + s );
		 } else {
			 System.out.println( "c NOT Found > " + s );
		 }
		 
		 
		 if( find.containsByIndex( s) ) {
			 System.out.println( "cbi YES Found > " + s );
		 } else {
			 System.out.println( "cbi NOT Found > " + s );
		 }
		 
		 
	}

}
