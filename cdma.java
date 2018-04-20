import java.util.*;

class ortho
{
	public static int arraysum(int x[])
	{
		int sum=0;
		for(int i=0;i<x.length;i++)
		{
			sum=sum+x[i];
		}
		
		return sum;
	}
	
	public static void main(String args[])
	{
		Scanner sc = new Scanner(System.in);
		
		System.out.println("CDMA Orthogonality");
	
		System.out.println("Enter Ad");
		
		int ad = sc.nextInt();
		
		if(ad==0)
			ad=-1;
		
		System.out.println("Enter Bd");
		
		int bd = sc.nextInt();
		
		if(bd==0)
			bd=-1;
		
		System.out.println("Enter length of Ak");
		
		int n = sc.nextInt();
		
		System.out.println("Enter Ak sequence in 0 and 1");
		
		int ak[] = new int[n];
		
		int i,j;
		
		for(i=0;i<n;i++)
		{
			ak[i]=sc.nextInt();
		}
		
		System.out.println("Enter length of Bk");
		
		n = sc.nextInt();
		
		int bk[] = new int[n];
		
		System.out.println("Enter Bk sequence in 0 and 1");
		
		for(i=0;i<n;i++)
		{
			bk[i] = sc.nextInt();
		}
		
		// Accept end
		
		for(i=0;i<ak.length;i++)
		{
			if(ak[i]==0)
			{
				ak[i]=-1;
			}
		}
		
		for(i=0;i<bk.length;i++)
		{
			if(bk[i]==0)
			{
				bk[i]=-1;
			}
		}
		
		n = ak.length;
		
		int as[] = new int[n];
		
		n = bk.length;
		
		int bs[] = new int[n];
		
		for(i=0;i<as.length;i++)
		{
			as[i]=ad*ak[i];
		}
		
		for(i=0;i<bs.length;i++)
		{
			bs[i]=bd*bk[i];
		}
		
		System.out.println("As Array is:");
		
		for(i=0;i<n;i++)
		{
			System.out.print(as[i]);
		}
		System.out.println();
		
		System.out.println("Bs Array is:");
		
		for(i=0;i<n;i++)
		{
			System.out.print(bs[i]);
		}
		System.out.println();
		
		int s[] = new int[n];
		
		for(i=0;i<n;i++)
		{
			s[i]=as[i]+bs[i];
		}
		
		int news[] = new int[n];
		
		for(i=0;i<n;i++)
		{
			news[i]=s[i]*ak[i];
		}
		
		System.out.print("S x Ak = ");
		
		for(i=0;i<n;i++)
		{
			System.out.print(news[i]);
		}
		System.out.println();
		
		int res = ortho.arraysum(news);
		
		System.out.println("Array sum 1 is " + res);
		
		for(i=0;i<n;i++)
		{
			news[i]=s[i]*bk[i];
		}
		
		res = ortho.arraysum(news);
		
		System.out.println("Array sum 2 is " + res);
		
		if(res>0)
		{
			System.out.println("Bit 1 was set for Ad and Bit 0 was set for Bd");
		}
		else
		{
			System.out.println("Bit 0 was set for Ad and Bit 1 was set for Bd");
		}
	}
}
