/**
 * Provides functions for conversion between Fahrenheits and Celsius
 *
 * @author Marat Plotkin
 * @version 1.0
 * @since 6/22/2018
 *
 */

public class TemperatureConverter {

    // class variables and constants
    final private static double d_ABS_ZERO_FAHR = -459.67;      // absolute zero in fahrenheits
    final private static  double d_ABS_ZERO_CELS = -273.15;     // absolute zero in celsius

    // private methods
    private double roundTo (double dTemp, int nPrecision = 2) {
        /**
         * rounds double to the specified precision
         *
         * @param double dTemp - temperature
         * @param int nPrecision - required precision
         * @return double - dTemp with new precision set
         *
         */

        nPrecision = (nPrecision < 0) ? 2 : nPrecision;

        return (int)(Math.pow(10, nPrecision) * dTemp)/(Math.pow(10, nPrecision));
    }


    private boolean tempInRange (double dTemp, char chUnits = 'f') {}

    // public methods
    public double getAbsZeroCels() {
        return TemperatureConverter.d_ABS_ZERO_CELS;
    }

    public double getAbsZeroFahr() {
        return TemperatureConverter.d_ABS_ZERO_FAHR;
    }

    public double celsToFahr(double dTemp, int nPrecision = 2) {}

    public double[] celsToFahr(double[] dTemp, int nPrecision = 2) {}

    public double fahrToCels(double dTemp, int nPrecision = 2) {}

    public double[] fahrToCels(double[] dTemp, int nPrecision = 2) {}

    // testing
    public static void main() {
        double testNum = 245.34566;
        System.out.println(roundTo(testNum))®;
    }

}