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
    public static double roundTo (double dTemp, int nPrecision = 2) {
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


    private static boolean tempInRange (double dTemp, char chUnits = 'f') {}

    // public methods
    public static double getAbsZeroCels() {
        return TemperatureConverter.d_ABS_ZERO_CELS;
    }

    public static double getAbsZeroFahr() {
        return TemperatureConverter.d_ABS_ZERO_FAHR;
    }

    public static double celsToFahr(double dTemp, int nPrecision = 2) {}

    public static double[] celsToFahr(double[] dTemp, int nPrecision = 2) {}

    public static double fahrToCels(double dTemp, int nPrecision = 2) {}

    public static double[] fahrToCels(double[] dTemp, int nPrecision = 2) {}

    // testing
    public static void main(String[] args) {
        double testNum = 245.34566;
        System.out.println(TemperatureConverter.roundTo(testNum));
    }

}