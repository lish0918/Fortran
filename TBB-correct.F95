PROGRAM TBB2GRADS

IMPLICIT NONE
INTEGER, PARAMETER	:: tbb_file = 13
CHARACTER(LEN=128)	:: fname(15) 

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
!------------------------------------------------------------------------  
!------------------------------------------------------------------------ 
integer::area(15),n,tbbmin  
character*2 c
!! The following is the TBB data file
 do n=1,15
    if(n<=4) then
        write(c,'(I1)') n+5
        fname(n)="New_FY2C_TBB_IR1_OTG_20060610_0"//trim(adjustl(c))//"00.AWX"
    else
        write(c,'(I2)') n+5
        fname(n)="New_FY2C_TBB_IR1_OTG_20060610_"//trim(adjustl(c))//"00.AWX"
    endif
end do

open(30,file="tbb_plot1.data",form="formatted",access="sequential")

do n=1,15
    area(n)=0
    tbbmin=1000
    OPEN (UNIT = tbb_file, FILE =fname(n), FORM = 'unformatted', STATUS = 'OLD' )
!------------------------------------------------------------------------
!------------------------------------------------------------------------ 
        !read the first record
           READ ( UNIT = tbb_file ) &
            FileName, ByteOrder, FirstHeaderLen, SecondHeaderLen, &
                FilledDataLen, RecordLen, HeaderRecordNum, &
            DataRecordNum, ProductClass, CompressMode, FormatDescStr, &
            DataQualityFlag

           !print*,FileName, ByteOrder, FirstHeaderLen, SecondHeaderLen, &
           !     FilledDataLen, RecordLen, HeaderRecordNum, &
           ! DataRecordNum, ProductClass, CompressMode, FormatDescStr, &
           ! DataQualityFlag

    !read the second record
         READ ( UNIT = tbb_file ) &
            SatName, GridElem, GridByte, GridBaseVal, GridRatioFactor, &
            TimeRan,  StartYear,StartMon,StartDay,StartHour, &
            StartMin, Endear,EndMon,EndDay,EndHour,EndMin,  &
            LeftLat,LeftLon,RightLat,RightLon,DxUnit,XDx,YDx,&
            XGridNum,YGridNum,Oth1,Oth2,Oth3,Oth4,Oth5,Oth6,Oth7,&
            Oth8,Oth9,Oth10,Oth11,Oth12
         !print*,SatName, GridElem, GridByte, GridBaseVal, GridRatioFactor, &
         !  TimeRan,  StartYear,StartMon,StartDay,StartHour, &
         !  StartMin, Endear,EndMon,EndDay,EndHour,EndMin,  &
         !   LeftLat,LeftLon,RightLat,RightLon,DxUnit,XDx,YDx,&
         !   XGridNum,YGridNum,Oth1,Oth2,Oth3,Oth4,Oth5,Oth6,Oth7,&
         !   Oth8,Oth9,Oth10,Oth11,Oth12        
            

    !read the third record (Note: some tbb data may donn't have the third record)
           ALLOCATE (FilledSection(FilledDataLen))
           READ ( UNIT=tbb_file)  FilledSection
            

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
!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
    do I=291,331
        do J=731,771
            if(tbb(I,J)<tbbmin) then
                tbbmin=tbb(I,J)
            end if
            if(tbb(I,J)<241) then
                area(n)=area(n)+1
            end if
        end do
    end do
    print *,tbbmin,area(n)
    write(30,*)tbbmin,area(n)
 !------------------------------------------------------------------------
 !------------------------------------------------------------------------ 
    ! Now close all the allocatable dimentions 
        DEALLOCATE (TbbData)
        DEALLOCATE (tbb)
        DEALLOCATE (FilledSection)
        CLOSE (tbb_file) 
end do
                   
close(30)	
END PROGRAM 
