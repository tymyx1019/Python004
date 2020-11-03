from django.db import models

# Create your models here.

class Comments(models.Model):
    user_name = models.CharField(max_length=32)
    comment_content = models.CharField(max_length=1000, null=False)
    rating = models.SmallIntegerField(max_length=2,null=False,default=0)
    pub_date = models.DateField()


