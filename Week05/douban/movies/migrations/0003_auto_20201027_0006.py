# Generated by Django 2.2.13 on 2020-10-26 16:06

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('movies', '0002_comments_rating'),
    ]

    operations = [
        migrations.AlterField(
            model_name='comments',
            name='pub_date',
            field=models.DateField(),
        ),
    ]