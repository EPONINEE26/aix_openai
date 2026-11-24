from django.db import models

class Tour(models.Model):
    tlist = models.CharField(max_length=100)
    tplace = models.CharField(max_length=1000)
    tstay = models.CharField(max_length=100)
    tfood = models.CharField(max_length=100)
    tdate = models.DateTimeField(auto_now=True,blank=True,null=True)

    def __str__(self):
        return f'{self.tlist},{self.tplace},{self.tstay},{self.tfood},{self.tdate}'
