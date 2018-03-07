EyeWitness=$(locate EyeWitness)
mkdir EyeWitness2
for file in $EyeWitness;do
	cp -r $file EyeWitness2
done
