---
layout: page-with-header
title: TIBCO ActiveSpaces<sup>®</sup> Tutorials
subhead: Getting Started with TIBCO ActiveSpaces<sup>®</sup>
lead: Geting started with TIBCO ActiveSpaces<sup>®</sup>
top_nav_list_name: activespaces
side_nav_list_name: getstarted
---



## Getting Started with TIBCO ActiveSpaces

This document helps you quickly understand some of the basic concepts of TIBCO ActiveSpaces and then walks you through how to write and run a simple ActiveSpaces Java application. Since most readers will be familiar with relational database concepts, we start by presenting some of the basic concepts of ActiveSpaces in terms of databases.  

*  A Tuple is the basic data container for ActiveSpaces. A tuple can be thought of as the equivalent of a row in a relational database management system.
*  A Space can be thought of as the equivalent of a database table. However with ActiveSpaces, a Space is in-memory and is typically distributed across several systems for scalability, fault-tolerance, and increased performance.
* A Space Member is an ActiveSpaces application that joins a space. An application can join a space and provide system resources (memory) for storing the tuples of the space, or an application can just access the data in the space without committing to provide any memory for the space. If a space member provides memory for a space, the member is called a *seeder* for the space. The tuples of the space are distributed across all of the seeders for the space. This implies that at least one seeder must be provided for a space in order to store data in a space. Space members which do not provide any memory for the space are known as *leeches*.
* A Metaspace can be thought of as the equivalent of a database. A metaspace can have any number of spaces and is limited only by your available systems' resources.  
* A Metaspace Member is an ActiveSpaces application that joins a metaspace. By default, any application can create a metaspace and then join it. If an application creates a metaspace which already exists, a handle to the existing metaspace is returned to the application instead of creating a handle to a new metaspace. In database terms, becoming a metaspace member is the equivalent of being connected to a database server and "using" a database.
  
See how easy this is? The only concepts which might be new to you are Metaspace Members and Space Members. Unlike a database which has a single server or daemon, ActiveSpaces uses its *seeder* members to provide the resources and services of a normal database server.

## Writing Your First ActiveSpaces Application
  
Now that we've seen how TIBCO ActiveSpaces is not that different from a database, let's see how easy it is to write an application which stores some data into ActiveSpaces. ActiveSpaces provides the following language APIs:

* Java  
*  C  
* .NET  

For our purposes, we'll focus on the Java API; but anything we do using the Java API can also be done in one of the other language APIs.

The following are the steps for writing a simple ActiveSpaces Java application which stores the string "Hello World" into ActiveSpaces:
    
1. Connect to a Metaspace. 
2. Create a Space for holding data.  
3. Join the Space.  
4. Put "Hello World" into the Space.
5. Leave the Space and disconnect from the Metaspace.

Connecting to a Metaspace
-------------------------

The first thing any ActiveSpaces application needs to do is to connect to a metaspace. Enter the following code and then we'll walk through what the code is doing.
    
	// excluding imports for now
	public class HelloWorld {

		public static void main(String[] args)
		{
			Metaspace ms = null;
			try
			{
				// define Metaspace membership characteristics
				MemberDef memberDef = MemberDef.create();
				memberDef.setDiscovery("tibpgm://4567");
				memberDef.setMemberName("hwmember");
				
				// connect to the Metaspace
				String metaspaceName = "GettingStarted";
				ms = Metaspace.connect(metaspaceName, memberDef);
			}
			catch (ASException e)
			{
				e.printStackTrace();
			}
		}
	}

Let's look at the first three lines of code in the main method:

	// define Metaspace membership characteristics
	MemberDef memberDef = MemberDef.create();
	memberDef.setDiscovery("tibpgm://4567");
	memberDef.setMemberName("hwmember");

The first line of code creates a MemberDef object. Because a Metaspace is distributed across its member's systems, Metaspace members all need to be able to communicate to each other. The MemberDef object is where you define how you connect to a Metaspace and how other Metaspace members can communicate with you. It is also where you can specify the settings for more advanced Metaspace membership characteristics such as security. But for now, we'll just focus on a couple of basic settings for Metaspace members.

Line two of the code specifies the Metaspace Discovery URL for connecting to the Metaspace. The Discovery URL specifies how to communicate to the manager(s) of the Metaspace. A Metaspace manager orchestrates the various database level functions of the Metaspace. The first member to connect to a Metaspace becomes the manager for the Metaspace. If the current manager leaves the Metaspace another Metaspace Member will be automatically chosen to be the new manager. If all Metaspace Members leave the Metaspace, then the Metaspace will no longer exist.

By default, ActiveSpaces uses a multicast transport, TIBCO PGM (Pragmatic General Multicast), for its Metaspace discovery networking transport. To ensure that our Metaspace will not conflict with any other Metaspace also using multicast discovery, we need to specify a port number which we hope that no one else will be using. In the example code, we are using port number **4567**. If anyone else runs this example on the same network you will both be working on the same Metaspace and you may not see the results you expect. **So it is important that you set the port number to something other than *4567* before you try to run this example**.

***
**User Action:** Set port number *4567* to some other available port number.
***

The third line of code specifies a name to use for our Metaspace Member. The name must be unique among all of a Metaspace's members. Specifying a member name is optional and a unique name will be automatically generated, if you do not specify a name. But the auto-generated name is not very readable or user friendly so it is common practice to specify a unique name that has meaning for your application.

Now we are ready to connect to our Metaspace.

	String metaspaceName = "GettingStarted";
	ms = Metaspace.connect(metaspaceName, memberDef);

To connect to a Metaspace, we use our previously created MemberDef object and specify the name of the Metaspace we want to connect to. If you do not specify a Metaspace name, the default name of *ms* will be used.

Each Metaspace is uniquely identified by its name and Discovery URL. If two applications on the same network use the same Metaspace name but each uses a different Discovery URL when connecting to a Metaspace, there will be two Metaspaces with the same name but the Metaspaces will operate independently of each other.

In the given code, notice that we have declared our Metaspace object outside of the try/catch block. This is done so that we can later disconnect cleanly from the Metaspace.

###Creating a Space
The next thing our application needs to do is to define our Space for storing some data. For now, we just want a simple Space that can hold the string "Hello World". So let's add some code to our main method to define a Space where each record holds a single string.


	public static void main(String[] args)
	{
		Metaspace ms = null;
		Space space = null;
		try
		{
			// define Metaspace membership characteristics
			MemberDef memberDef = MemberDef.create();
			memberDef.setDiscovery("tibpgm://4567");
			memberDef.setMemberName("hwmember");
			
			// connect to the Metaspace
			String metaspaceName = "GettingStarted";
			ms = Metaspace.connect(metaspaceName, memberDef);
			
			// define the fields of the Space
			FieldDef fieldDef = FieldDef.create("value", FieldType.STRING);
			// define the key fields of the Space
			KeyDef keyDef = KeyDef.create().setFieldNames("value");
			
			// define the Space
			SpaceDef spaceDef = SpaceDef.create();
			String spaceName = "StringSpace";
			spaceDef.setName(spaceName);
			spaceDef.putFieldDef(fieldDef);
			spaceDef.setKeyDef(keyDef);
			
			// create the Space
			ms.defineSpace(spaceDef);
		}
		catch (ASException e)
		{
			e.printStackTrace();
		}
	}


A Space can contain any number of fields for storing data. For our example, we just need one field to hold the string "Hello World". So we first create a FieldDef object with a field name of "value" and a type of STRING.

	FieldDef valueField = FieldDef.create("value", FieldType.STRING);


To be able to easily retrieve data from a Space, we also need to specify which field of the Space will act as the key field. So we create a KeyDef object and specify that the key field will be the field named "value".

	KeyDef keyFields = KeyDef.create().setFieldNames("value");

Next we compose the entire definition of our Space.

	SpaceDef spaceDef = SpaceDef.create();
	String spaceName = "StringSpace";
	spaceDef.setName(spaceName);
	spaceDef.putFieldDef(valueField);
	spaceDef.setKeyDef(keyFields);

We create a SpaceDef object to hold the FieldDefs, KeyDef and other settings which define our Space. We set the name of the Space to "StringSpace" and populate the SpaceDef with the FieldDef and KeyDef we have created.

Finally, we create the Space within the Metaspace.

	ms.defineSpace(spaceDef);

### Joining a Space
When you join a Space, you become a Member of the Space. As mentioned above, there are two types of Space Members: seeders and leeches. The data in a Space is stored in the memory of the seeder Space Members. So for our example, we want to join the Space we just created as a seeder since we will be the only member of the Space.

Add the following lines of code to our program after the line *ms.defineSpace(spaceDef);* :

	space = ms.getSpace(spaceName, DistributionRole.SEEDER);
	space.waitForReady();

The first line is where we actually join the space as a seeder and retrieve the Space handle from the Metaspace object.

The second line causes our program to block until the Space is ready to handle operations. When you first join a Space, there is some housekeeping that is done which may take some time depending upon the number of members in the Space and how much data is stored in the Space. So when first joining a Space, it is always best to wait until the Space becomes ready before continuing on.

### Storing Data in a Space
We have a connection to a Metaspace and we have joined a Space. Now we can finally put some data into the Space. Add the following lines of code to our program before the end of our try block.

	Tuple tuple = Tuple.create();
	tuple.put("value", "Hello World");
	space.put(tuple);

ActiveSpaces uses a Tuple data structure for holding the data of a Space. Each Tuple entry holds a name/value pair.

Our Space is defined to hold one field. The field is named 'value' and is defined to hold a string. So we create a Tuple and put the field name "value" and the string "Hello World" into the Tuple. We then put the Tuple into the Space we created earlier.

Now let's check that our data is in the space. We can use the Space.get() method to retrieve a copy of the Tuple that was stored in the Space. Add the following code to our program after the code we just added for putting "Hello World" into the Space:


	Tuple result = space.get(tuple);
	if (result != null)
	{
		System.out.println("Value: " + result);
	}
	else
	{
		System.out.println("Hello World does not exist in the Space");
	}


Using our original tuple for the space.get(tuple) call, we are telling the Space to return the Tuple from the Space whose field named *value* has a value of "Hello World".
 
### Cleaning up

We're almost ready to build and test our program. But we have some cleanup code to add. Whenever you join a Space, you should also leave the Space when you are done using the Space. Likewise when you connect to a Metaspace, you should disconnect from it when you are done. So let's add the following final bit of cleanup code to the end of our main method.

	try
	{
		// leave the space
		if (space != null)
			space.close();
		// disconnect from the metaspace
		if (ms != null)
			ms.close();
	}
	catch (ASException ex)
	{
		ex.printStackTrace();
	}

### The Full Java Program

Before we can build and run our Java program, we need to add in the import statements for our ActiveSpaces classes. Here is the full code for our example:

&gt;&gt;Important! If you copy and paste this entire program locally, remember to change port 4567 to another available port on your local system which you hope no one else running the same program might use.  


	import com.tibco.as.space.ASException;
	import com.tibco.as.space.FieldDef;
	import com.tibco.as.space.KeyDef;
	import com.tibco.as.space.MemberDef;
	import com.tibco.as.space.Metaspace;
	import com.tibco.as.space.Space;
	import com.tibco.as.space.SpaceDef;
	import com.tibco.as.space.Tuple;
	import com.tibco.as.space.FieldDef.FieldType;
	import com.tibco.as.space.Member.DistributionRole;


	public class HelloWorldFinal {

		public static void main(String[] args)
		{
			Metaspace ms = null;
			Space space = null;
			try
			{
				// define Metaspace membership characteristics
				MemberDef memberDef = MemberDef.create();
				memberDef.setDiscovery("tibpgm://4567");
				memberDef.setMemberName("hwmember");
				
				// connect to the Metaspace
				String metaspaceName = "GettingStarted";
				ms = Metaspace.connect(metaspaceName, memberDef);

				// define the fields of the Space
				FieldDef valueField = FieldDef.create("value", FieldType.STRING);
				// define the key fields of the Space
				KeyDef keyFields = KeyDef.create().setFieldNames("value");
				
				// define the Space
				SpaceDef spaceDef = SpaceDef.create();
				String spaceName = "StringSpace";
				spaceDef.setName(spaceName);
				spaceDef.putFieldDef(valueField);
				spaceDef.setKeyDef(keyFields);
				
				// create the Space
				ms.defineSpace(spaceDef);
				
				// join the Space as a seeder so it has memory to store data
		        space = ms.getSpace(spaceName, DistributionRole.SEEDER);
		        
		        // block until the space is ready to use
		        space.waitForReady();
		        
				// put some data into the Space and then read it back out
				Tuple tuple = Tuple.create();
				tuple.put("value", "Hello World");
				space.put(tuple);
				
				// we get data out of a space by its key
	            Tuple result = space.get(tuple);
	            if (result != null)
	            {
	                System.out.println("Value: " + result);
	            }
	            else
	            {
	                System.out.println("Hello World does not exist in the Space");
	            }
			}
			catch (ASException e)
			{
				e.printStackTrace();
			}
			
			// clean up
			try
			{
				// leave the space
				if (space != null)
					space.close();
				// disconnect from the metaspace
			    if (ms != null)
				    ms.close();
			}
			catch (ASException ex)
			{
				ex.printStackTrace();
			}
		}
	}


### Setting Up Our Environment

Before we try to build our example, we first need to make sure our environment is set up properly. ActiveSpaces needs to be installed on your system and since this is a Java program, the Java JDK also needs to be installed. Then set up your environment as follows:

1. Prepend the ActiveSpaces bin directory to your path.
2. Set your environment to include the ActiveSpaces lib directory as follows:
  - For Windows, prepend the ActiveSpaces lib directory to your path.
  - On UNIX, set the LD_LIBRARY_PATH to include the ActiveSpaces lib directory.
  - On OSX, set the DYLD_LIBRARY_PATH to include the ActiveSpaces lib directory.
3. Set your path to include the Java JDK bin directory.
4. Set your CLASSPATH to include the ActiveSpaces jar files.
5. Set your CLASSPATH to include the Java JRE lib directory.
6. Set your CLASSPATH to include the current directory so that our example class can be found.
    
For example, if ActiveSpaces is installed in the following directory:

	c:\tibco\as\2.1

and the Java JDK is installed in the following directory:

	c:\Program Files\Java\jdk1.7.0_51


you would do the following for Windows:

	set AS_HOME=c:/tibco/as/2.1
	set JDK_HOME=c:/"Program Files"/Java/jdk1.7.0_51

	set PATH=%AS_HOME%/bin;%AS_HOME%/lib;%JDK_HOME%/bin;%PATH%
	set CLASSPATH=%AS_HOME%/lib/as-common.jar;%JDK_HOME%/jre/lib;.


### Building and Running Our Example

Now we are ready to build and run our HelloWorld example program. To compile the example enter the following at the command prompt:

	javac HelloWorld.java


Given that the compilation completed OK and you didn't make any typos, to run the program type the following:

	java HelloWorld

You should see some logging messages from ActiveSpaces as the Metaspace is initialized and lastly you should see the output from our program after successfully retrieving "Hello World" back from the Space.

	Value: {Tuple {value=Hello World} }


### What's Next?
Now that you've learned how to write a very basic Java program using ActiveSpaces, you can learn more about ActiveSpaces by working through each of the examples documented in Chapter 5 of the TIBCO ActiveSpaces Developer's Guide. Start with the ASOperations example which will build on what you have learned here but additionally teach you how to perform operations such as *put* and *get* with multiple tuples, browse the data in a Space, lock and unlock the data in a Space, and use transactions.

As you become more comfortable with ActiveSpaces and want to learn more about its powerful capabilities, read the other chapters of the Developer's Guide and work with the other examples in Chapter 5. This will allow you to gain more experience developing applications which use the various features of ActiveSpaces.









