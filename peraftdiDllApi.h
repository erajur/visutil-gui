/*
* Filename:	peraftdiDllApi.h
* Project:	
*
* copyright (c) Pera/EII 2015
*                                                             
* The copyright to the computer Program(s) herein is the      
* property of Pera/Eii. The program(s) may be      
* used and or copied only with the written permission of      
* Pera/Eii, or in accordance with the terms and conditions 
* stipulated in the agreement contract under which the        
* program(s) have been supplied.                              
*
* File Description:
* 1. PeraDSP_x functions should contain only standard data types
* compatible with matlab. They need to be type_casted in 
* Exports.cpp file.
*/

#ifndef _PERAFTDIDLLAPI_H_
#define _PERAFTDIDLLAPI_H_

/***** Include files *****************************************/

/***** Defines ***********************************************/
#ifdef PERAFTDI_EXPORTS
#undef PERAFTDI_EXPORTS
#define PERAFTDI_EXPORTS __declspec(dllexport) 
#else
#define PERAFTDI_EXPORTS __declspec(dllimport)
#endif


#ifdef _DEBUG
 #define		LIBRARY_NAME		("peraftdi_d64.dll")
#else
 #define		LIBRARY_NAME		("peraftdi.dll")
#endif

#define		DLL_REVISION		("1.0.0.0")

//typedef void *PVOID;
//typedef PVOID	FT_HANDLE;

typedef struct {
	long Flags;
	long Type;
	long ID;
	long LocId;
	char SerialNumber[16];
	char Description[64];
	//char *str;
	void *ftHandle;
} Matlab_lib_test;

#ifdef __cplusplus
extern "C"	{
#endif  /* __cplusplus */

PERAFTDI_EXPORTS void PeraFTDI_vDLLVersion(char*);
PERAFTDI_EXPORTS int PeraFTDI_iMatLabImportExportLibTest(Matlab_lib_test *st);
PERAFTDI_EXPORTS int PeraFTDI_iMatLabDoublePtrLibTest(void ** phandle);

//PERAFTDI_EXPORTS int PeraFTDI_iOpenHandler(char* name, unsigned int *numChans);
//PERAFTDI_EXPORTS int PeraFTDI_iOpenHandle(char* name, unsigned int *numChans, void* ftHandle);
//PERAFTDI_EXPORTS int PeraFTDI_iOpenHandle(char* name, unsigned long long *numChans, unsigned long long* ftHandle);
//PERAFTDI_EXPORTS int PeraFTDI_iCloseHandle(unsigned long long* ftHandle);
PERAFTDI_EXPORTS int PeraFTDI_iSpiDeviceOpen(char* name, unsigned long long* ftHandle);
PERAFTDI_EXPORTS int PeraFTDI_iSpiDeviceClose(unsigned long long* ftHandle);
PERAFTDI_EXPORTS int PeraFTDI_iSpiWriteData(unsigned long long* ftHandle, unsigned long addr, const unsigned char* buffer, unsigned long sizeToTransfer);
PERAFTDI_EXPORTS int PeraFTDI_iSpiReadData(unsigned long long* ftHandle, unsigned long addr, unsigned char* buffer, unsigned long sizeToTransfer);
PERAFTDI_EXPORTS int PeraFTDI_iSpiRead_ID(unsigned long long* ftHandle, unsigned char* buffer, unsigned long sizeToTransfer);
PERAFTDI_EXPORTS int PeraFTDI_iSpiEraseAll(unsigned long long* ftHandle);
PERAFTDI_EXPORTS int PeraFTDI_iSpiWriteStatus(unsigned long long* ftHandle, unsigned char config);
PERAFTDI_EXPORTS int PeraFTDI_iSpiSectorErase(unsigned long long* ftHandle, unsigned long subSector);

#ifdef __cplusplus
}
#endif  /* __cplusplus */

#endif // #ifndef _FILE_NAME_H_
/* EOF */

