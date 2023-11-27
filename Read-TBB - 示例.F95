PROGRAM TBB2GRADS

IMPLICIT NONE
INTEGER, PARAMETER	:: tbb_file = 13
CHARACTER(LEN=128)	:: tbb_file_name 

CHARACTER(LEN=2) :: DATE = '12'
CHARACTER(LEN=2),DIMENSION(48) :: MIN 
	
CHARACTER(LEN=3), DIMENSION(12)	:: StrMonth
CHARACTER(LEN=3)	:: StartMonth
CHARACTER(LEN=12)	:: StrDate
INTEGER :: I,J,x_center,y_center


!! For the first record's members
CHARACTER(LEN=12) :: FileName
CHARACTER(LEN=8)  :: FormatDescStr
INTEGER (2) :: ByteOrder, FirstHeaderLen, SecondHeaderLen, &
                   FilledDataLen, RecordLen, HeaderRecordNum, &
                   DataRecordNum, ProductClass, CompressMode, &
                   DataQualityFlag
														
!!For the second record's members
CHARACTER(LEN=8)	:: SatName
INTEGER(2)	:: GridElem, GridByte, GridBaseVal, GridRatioFactor, &
	               TimeRan,  StartYear,StartMon,StartDay,StartHour, &
				   StartMin, Endear,EndMon,EndDay,EndHour,EndMin,  &
				   LeftLat,LeftLon,RightLat,RightLon,DxUnit,XDx,YDx,&
				   XGridNum,YGridNum,Oth1,Oth2,Oth3,Oth4,Oth5,Oth6,Oth7,&
				   Oth8,Oth9,Oth10,Oth11,Oth12

	
!! Here are for the tbb data
CHARACTER(1), ALLOCATABLE	:: TbbData(:,:)
REAL, ALLOCATABLE	:: tbb(:,:)
INTEGER(1), ALLOCATABLE :: FilledSection(:)
DATA StrMonth / 'jan', 'feb', 'mar', 'apr', 'may', &
					'jun', 'jul', 'aug', 'sep', 'oct', &
					'nov', 'dec' /
  
  

!! The following is the TBB data file

 tbb_file_name='New_FY2C_TBB_IR1_OTG_20060610_0600.AWX'

!!!

OPEN (UNIT = tbb_file, FILE =tbb_file_name, FORM = 'unformatted', STATUS = 'OLD' )



!read the first record
       READ ( UNIT = tbb_file ) &
		FileName, ByteOrder, FirstHeaderLen, SecondHeaderLen, &
	        FilledDataLen, RecordLen, HeaderRecordNum, &
	 	DataRecordNum, ProductClass, CompressMode, FormatDescStr, &
		DataQualityFlag

       print*,FileName, ByteOrder, FirstHeaderLen, SecondHeaderLen, &
	        FilledDataLen, RecordLen, HeaderRecordNum, &
	 	DataRecordNum, ProductClass, CompressMode, FormatDescStr, &
		DataQualityFlag

!read the second record
	 READ ( UNIT = tbb_file ) &
		SatName, GridElem, GridByte, GridBaseVal, GridRatioFactor, &
		TimeRan,  StartYear,StartMon,StartDay,StartHour, &
		StartMin, Endear,EndMon,EndDay,EndHour,EndMin,  &
		LeftLat,LeftLon,RightLat,RightLon,DxUnit,XDx,YDx,&
		XGridNum,YGridNum,Oth1,Oth2,Oth3,Oth4,Oth5,Oth6,Oth7,&
		Oth8,Oth9,Oth10,Oth11,Oth12
     print*,SatName, GridElem, GridByte, GridBaseVal, GridRatioFactor, &
		TimeRan,  StartYear,StartMon,StartDay,StartHour, &
		StartMin, Endear,EndMon,EndDay,EndHour,EndMin,  &
		LeftLat,LeftLon,RightLat,RightLon,DxUnit,XDx,YDx,&
		XGridNum,YGridNum,Oth1,Oth2,Oth3,Oth4,Oth5,Oth6,Oth7,&
		Oth8,Oth9,Oth10,Oth11,Oth12        
        

!read the third record (Note: some tbb data may donn't have the third record)
       ALLOCATE (FilledSection(FilledDataLen))
	   READ ( UNIT=tbb_file )  FilledSection
        

! Now we read the tbb data records
	ALLOCATE (TbbData(YGridNum,XGridNum))
	ALLOCATE (tbb(YGridNum,XGridNum))
	
	DO I=1,YGridNum
	READ ( UNIT = tbb_file )(TbbData(I,J),J=1,XGridNum)
	ENDDO

! Now transfer the data into real temperature data 
	tbb =  ICHAR(TbbData)
	tbb  = (tbb+GridBaseVal)*GridRatioFactor
 !   print*,	tbb



! Now close all the allocatable dimentions 
	DEALLOCATE (TbbData)
	DEALLOCATE (tbb)
	DEALLOCATE (FilledSection)
	CLOSE ( tbb_file )
                   
	
END PROGRAM 
