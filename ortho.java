import java.util.*;

class ortho
{
 public static void main ( String args[] )
 {
 	int a[] = new int[20];
 	int b[] = new int[20];
 	int c[] = new int[20];
	int n;
	Scanner t= new Scanner(System.in);
	System.out.println("Enter the length");
	n=t.nextInt();
	int i,j;
	System.out.println("Enter 1st code");
	for(i=0;i<n;i++)
	{
		a[i]=t.nextInt();
		if(a[i]==0)
			a[i]=-1;
	}
	System.out.println("Enter 2nd code");
	for(i=0;i<n;i++)
	{
		b[i]=t.nextInt();
		if(b[i]==0)
			b[i]=-1;
	}
	int r=0;
	for(i=0;i<n;i++)
	{
		c[i]=a[i]*b[i];
		r=r+c[i];
	}
	if(r==0)
		System.out.println("Codes are Orthogonal");
	else
		System.out.println("Codes are not Orthogonal");
 }
}
