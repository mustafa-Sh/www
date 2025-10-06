package com.path.bo.common;

public class ConstantsCommon
{
    public static final String APP_VERSION = "1401000000000214003";
    public static final String APP_NAME = "IBIS";
    // Application common component version, specified during build process
    public static final String COMMON_COMP_VERSION = "Common 14.5.0";
    public static final String APP_BUILD_DATE_TIME = "";
    
    //display version
    public static final String DISPlAY_APP_VERSION = "ReducedWar 14.1.0.0";
    
    /**
     * Mappers encryption management
     */
    public static final String MAPPERS_ENCRYPTION_PASS = "xxxxx";
    /**
     * Internal Build Version ApplicationName.Year.DayOfYear.BuildWithinTheDay
     */
    public static final String APP_INTERNAL_BUILD_VERSION = "IBIS 0.2019.107.1";
    
    public static String returnAppVersion()
    {
	return APP_VERSION;
    }
    /**
     * Method needed to return the Constants Common Display Version, to avoid including static version upon compilation into Files 
     * @return
     */
    public static String returnAppDisplayVersion()
    {
	return DISPlAY_APP_VERSION;
    }
    /**
     * method used to return the app numeric version from the DISPlAY_APP_VERSION which will contains only numbers 
     * @return
     */
    public static String returnAppNumericVersion()
    {
	return DISPlAY_APP_VERSION == null?"":DISPlAY_APP_VERSION.replaceAll("\\D+","");
    }
    /**
     * Method needed to return the Constants Common Display Version, to avoid including static version upon compilation into Files 
     * @return
     */
    public static String returnAppInterBuildVersion()
    {
	return APP_INTERNAL_BUILD_VERSION;
    }
    /**
     * Method needed to return the constants Common APP_NAME to avoid including static APP Name upon compilation into files.
     * @return
     */
    public static String returnCurrentAppName()
    {
	return APP_NAME;
    }
    /**
     * Method needed to return the constants Common APP_BUILD_DATE_TIME to avoid including static APP_BUILD_DATE_TIME upon compilation into files.
     * @return
     */
    public static String returnAppBuildDate()
    {
	return APP_BUILD_DATE_TIME;
    }
    /**
     * Method needed to return the constants Common COMMON_COMP_VERSION to avoid including static COMMON_COMP_VERSION upon compilation into files.
     * @return
     */
    public static String returnAppCommonCompVersion()
    {
	return COMMON_COMP_VERSION;
    }
}

