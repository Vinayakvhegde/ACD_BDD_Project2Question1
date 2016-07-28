package udf_project2;

import java.io.IOException;

import org.apache.pig.EvalFunc;
import org.apache.pig.data.Tuple;

public class PecentageUDF extends EvalFunc <Double>
{
	public double calcPercentage (String strNum1, String strNum2) 
		throws ArithmeticException, NumberFormatException 
	{
		double percentage = 0 ;
		try
		{
			double number1 = Double.parseDouble(strNum1) ;
			double number2 = Double.parseDouble(strNum2) ;
			if ((number1 <=0 ))
			{
				return 0.00 ;
			}else
			{
				try 
				{
					percentage = ((number2/number1) * 100 );
					return percentage ;
				}catch (ArithmeticException A)
				{
					return 999.99 ;
				}
			}
		}catch (NumberFormatException n)	 
		{
			return 999.99 ;
		}
		
	}

	@Override
	public Double exec(Tuple input) throws IOException {
		// TODO Auto-generated method stub
		if ((input == null) || (input.size() != 2 ))
			return null;
		try {
			String str1 = (String) input.get(0) ;
			String str2 = (String) input.get(1) ;
			return calcPercentage(str1, str2) ;
		}catch (Exception e)
		{
			throw new IOException (" IO Exception thrown here" , e) ;
		}
	}

}
