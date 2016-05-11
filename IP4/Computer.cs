using System;
public class Program
{
	public static void Main()
	{
		Computer computer1 = new Laptop(1, "Null", "Null", "Webcam", 18);
		Computer computer2 = new Laptop(2, "Null", "Null", "Webcam", 18);
		Computer computer3 = new Desktop(3, "Null", "Null", "NO Webcam", 120);
		computer1.Update ("France","Webcam");
		computer2.Update ("Japan","Webcam");
		computer3.Update ("USA","Webcam");

}

//--------------------------------------Class Computer------------------------------------------

public class Computer
{
	public int ID { get; set; }
	public string Brand { get; set; }
	public string MadeIn { get; set; }
	public string Specs { get; set; }

	public virtual void Update(string manufactured, string Information)
	{
		MadeIn = manufactured;
		Specs = Information;
	}
	public Computer(int inID, string inBrand, string inMadeIn, string inSpecs)
	{
		ID = inID;
		Brand = inBrand;
		MadeIn = inMadeIn;
		Specs = inSpecs;
	}
}

//--------------------------------------Class Laptop------------------------------------------

// box has read only attributes length, width, and height
// is rated differently from normal packages - an additional charge
// per inch for every inch over a certain threshold 

//has read only attribute packageType
//
public class Laptop:Computer
{
	public int Pounds { get; set; }
	public Laptop(int inYear, string inBrand, string inMadeIn, string inSpecs, int inPounds)
		: base(inYear, inBrand, inMadeIn, inSpecs)
	{
		Pounds = inPounds;
	}
	public override void Update(string manufactured, string Information){
		//base.Update (manufactured, Information)
		if ( Specs == Information) {
			base.Update (manufactured, Information);
				Console.WriteLine ("Laptop ID: " + ID + "can be updated and has the following specs: "+ Information);
		}
		else {
			Console.WriteLine ("Laptop ID: " + ID + " was made in " + manufactured + " with specs: "+ Information);
		}
	}

}

////--------------------------------------Class Desktop------------------------------------------

public class Desktop:Computer
{
	public int Weight { get; set; }

	public Desktop(int inYear, string inBrand, string inMadeIn, string inSpecs, int inWeight)
		: base(inYear, inBrand, inMadeIn, inSpecs)
	{
		Weight = inWeight;
	}
	public override void Update(string manufactured, string Information){
			if ( Specs == Information) {
				base.Update (manufactured, Information);
				Console.WriteLine ("Destop ID: " + ID + "can be updated and has the following specs: "+ Information);
			}
			else {
				Console.WriteLine ("Destop ID: " + ID + " cannot take this update");
			}
			/*base.Update (manufactured,Information);
			Console.WriteLine ("Desktop ID: " + ID + " was made in " + manufactured+ " with specs: "+ Information);*/
	}
}
}

