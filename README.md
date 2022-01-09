# Imagefusion_BE_Project_2017

# OVERVIEW

1. - The presentation would deal with the following:
2. - Introduction
3. - Objective
4. - Literature survey
5. - Methodology
6. - Architecture Diagram
7. - Flowchart
8. - Experiments 
9. - Results
10. - Conclusion
11. - References

# INTRODUCTION
 In computer vision, Multi sensor Image fusion is the process of combining relevant information from two or more images into a single image. The resulting image will be more informative than any of the input images.

 Since IR sensors are able to capture thermal information in a scene that is not directly seen by human eyes, they can more clearly detect some objects in lowlight, occlusion and adverse weather conditions.

 Visible imagery normally provides more details of the scene in the visible spectrum, and also presents more natural intensities and contrasts that are consistent with human visual perception. 

 In this project, we present a multi scale fusion method to achieve better fusion results for human visual perception.

# OBJECTIVE

The main objective is to fuse images, the visible and infrared images, to enhance the information of output image  which could be helpful for many applications, especially for surveillance of sensitive border regions to locate enemies particularly in the forest/mountain areas. 

# PROBLEM STATEMENT 

In low light environment, only limited visual information can be captured by CCD cameras under poor lightning conditions, thus making it difficult to do  surveillance only by visual sensor. Therefore in this work, an image fusion technique is proposed that fuses low-light visible images and IR images capturing the same scene for better image understanding.

# ARCHITECTURE DIAGRAM

![image](https://user-images.githubusercontent.com/13836633/148679931-26fa0803-39b4-4b1d-ac68-c0dd1b7df751.png)


# FLOWCHART

![image](https://user-images.githubusercontent.com/13836633/148679933-6beac9e8-a10b-492a-9463-61721974aced.png)


# METHODOLOGY

The proposed approach comprises of two steps: 
   1. MSD based on Gaussian and Bilateral filters 
   2. Infrared and visible image fusion based on 
         2.1. Small and large-scale combinations.
         2.2. Base level combination. 

![image](https://user-images.githubusercontent.com/13836633/148679941-bac0058a-b2ca-474e-865a-94aca98a7a88.png)

<br> 
### Step 1 Small-Scale combination:<br> 
Small scale combination is used to integrate fine-scale features into fused image it is applied to the original image. The value of lambda is used to regulate the amount of IR image features to be injected in the visible image for better visual perception.
<br>
<br> 
### Step 2 Large-Scale combination:<br>
 The large-scale levels are chosen to include all the decomposed levels. At these scale levels, the decomposed large-scale edge features are fully used to identify and determine the weights of corresponding IR spectral features that would be injected into the visible image.
<br>
<br> 
### Step 3 Base-Level combination:<br>
 The use of base image in image fusion is that it generally provides the support information for the higher-frequency sub-bands. They are closely associated with each other in scale-spaces. So it is reasonable that the construction of the fused base image would also be related to the higher-level decomposed information in the fusion process.
<br>
<br>
 ![image](https://user-images.githubusercontent.com/13836633/148679952-512b1238-c260-4409-aae8-edcdbb26b070.png)


# EXPERIMENTS

 
We selected few of the standard visible and IR images which are, "meting012", "Road", "T1“, ”Dune”, ”Camp” ,”Road” , etc are been selected from "https://figshare.com/articles/TNO_Image_Fusion_Dataset " to assess the     performance of the proposed method. 

We considered other two existing methods Stationary Wavelet Tranform (SWT) and Pulse-Coupled Neural Network (PCNN) to compare the performance corresponding to the proposed hybrid MSD method. 

The corresponding comparison for different images set and various performance parameter are show in the graphs.

From the Graph and table we can see that the proposed methods in more efficient.

# INPUT  IMAGES

### Visible Image
![image](https://user-images.githubusercontent.com/13836633/148680069-a24551e3-2abb-4545-9f16-f20d816e5622.png)


### IR Image
![image](https://user-images.githubusercontent.com/13836633/148680083-9646165f-a629-4406-abc3-bc56b47d92e0.png)


# OUTPUT

![image](https://user-images.githubusercontent.com/13836633/148679979-fe43b7c9-e2e6-4c95-9f04-e1a7b63411d4.png)


# RESULTS
![image](https://user-images.githubusercontent.com/13836633/148679990-ae0b2119-926d-44e5-b2dc-b8e663ce7a57.png)
![image](https://user-images.githubusercontent.com/13836633/148679996-5f78d646-6df3-42e4-9162-6e02a31ea5d1.png)
![image](https://user-images.githubusercontent.com/13836633/148680003-0ee2709a-b891-40a3-bd73-1fcc66556147.png)
![image](https://user-images.githubusercontent.com/13836633/148680007-d92c38b5-3946-4fdc-b781-d8d6ef0a8e16.png)
![image](https://user-images.githubusercontent.com/13836633/148680016-58a8cf21-85d5-4063-b927-4789ead3b2f7.png)
![image](https://user-images.githubusercontent.com/13836633/148680019-d9d70f02-bac4-4d33-9300-f44825aa5741.png)


# CONCLUSION

In this project, a novel method to fuse Infrared (IR) and visible images has been proposed based on combining rule for a multi scale decomposition based image fusion. 

By further employing different combination algorithms adaptively according to different information scale levels in the fusion process, we can preserve or properly enhance the background scenery and details from the visible image which provide important perceptual cues for human observation.

Experimental results demonstrate that the proposed fusion method is able to provide perceptually better fusion results compared with various other pixel-based multi-scale fusion algorithms.

# REFERENCES

[1] Wei Gan, Xiaohong Wu, Wei Wu, Xiaomin Yang, Chao Ren, Xiaohai He, Kai Liu, "Infrared and visible image fusion with the use of multi-scale edge-preserving decomposition and guided image filter”, ELSEVIER Infrared Physics & Technology, Volume 72, September 2015, Pages 37–51

[2] Y. Chai, H.F. Li, J.F. Qu, "Image fusion scheme using a novel dual-channel PCNN in lifting stationary wavelet domain", ELSEVIER Optics Communications, Volume 283, Issue 19, 1 October 2010, Pages 3591–3602

[3] Weiwei Kong, Longjun Zhang, Yang Lei, "Novel fusion method for visible light and infrared images based on NSST–SF–PCNN", ELSEVIER Infrared Physics & Technology, Volume 65, July 2014, Pages 103–112

[4] Pusit Borwonwatanadelok, Wirat Rattanapitak and Somkait Udomhunsakul, "Multi-Focus Image Fusion based on Stationary Wavelet Transform and extended Spatial Frequency Measurement”, International Conference on Electronic Computer Technology 2009

