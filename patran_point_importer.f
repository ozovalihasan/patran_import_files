      program patran_point_importer
c     Author=Hasan ôzovalç
c     Mail=ozovalihasan@gmail.com
      
c     This program is written to import points to Patran as neutral file,
c     i.e. output of this program needed to be imported as neutral file by using Patran.
c     Program is written by using Fortran

c     If you represent company saling Patran, you may connect with me to remove
c     this program if it infringes your copyright.

c     This program doesn't guarantee to import all data properly. So,
c     before using it,you need to check all output data.The problem caused
c     by usage is responsibility of user.

c     This program and file used to keep all data of points must be in same file
c     Input file should be named as 'data.dat' . An example is provided.

      dimension a(2,200)
      CHARACTER(len=255) cwd
      CHARACTER(len=8)  date
      CHARACTER(len=10) time
      CHARACTER(len=5) zone
      CALL getcwd(cwd)
      call date_and_time(DATE=date,ZONE=zone)
      call date_and_time(TIME=time)
c     ----------------------

      g=9.81
      pi=4*ATAN(1.0)


      !NCOL is a limit for arrays. If NUMEL is bigger than NCOL, program will warn about this
      open(10,file=trim(cwd)//"\data.dat")
      read(10,*)j
      read(10,*)
      do i=1,j
         read(10,*)a(1,i),a(2,i)
         a(1,i)=a(1,i)*1000.
         a(2,i)=a(2,i)*1000.
         write(*,100)a(1,i),a(2,i)
      enddo

100   format(2e16.9)

      close(10)
      open(11,file="input.out")
      write(11,'(A)')"25       0       0       1       0       0       0&
     &       0       0"
       write(11,'(A)')"P3/PATRAN --------------------"
       write(11,'(A)')"26       0       0       1       0       0       &
     &0       0       0"
       write(11,*)date(7:8),'-',date(5:6),'-',date(3:4),'   ',time(1:2)  &
     &,':',time(3:4),':',time(5:6),'         ',zone(3:3),'.',zone(4:4)
       do i=1,140
       write(11,'(A,I3,A)')"31     ",i,"       0       1       0       0&
     &       0       0       0"
       write(11,'(e16.9e1,e16.9e1,A)')a(1,i),a(2,i),"  0.000000000E+0"

       enddo
       write(11,'(A)')"99       0       0       1       0       0       &
     &0       0       0"
      close(11)

      print*,'--------------------'
      print*,'Ouput file is output.out . You need to import it as neutra&
     &l file to use it'
     
     
      print*,'To finish program push any button'
      read(*,*)

      end
