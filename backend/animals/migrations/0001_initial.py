# Generated by Django 5.1.3 on 2024-11-28 12:48

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Animal',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=255)),
                ('species', models.CharField(max_length=255)),
                ('status', models.CharField(max_length=255)),
                ('breed', models.CharField(blank=True, max_length=255, null=True)),
                ('gender', models.CharField(blank=True, max_length=50, null=True)),
                ('birth_date_or_age', models.CharField(blank=True, max_length=255, null=True)),
                ('color_or_marks', models.TextField(blank=True, null=True)),
                ('microchip_number', models.CharField(blank=True, max_length=50, null=True)),
                ('current_weight', models.CharField(blank=True, max_length=50, null=True)),
                ('owner_name', models.CharField(blank=True, max_length=255, null=True)),
                ('owner_contact', models.CharField(blank=True, max_length=255, null=True)),
                ('owner_address', models.TextField(blank=True, null=True)),
                ('owner_appointments', models.JSONField(blank=True, null=True)),
                ('medical_history', models.JSONField(blank=True, null=True)),
                ('diet_notes', models.TextField(blank=True, null=True)),
                ('reproduction_notes', models.TextField(blank=True, null=True)),
                ('prescribed_drugs', models.JSONField(blank=True, null=True)),
                ('diagnostic_tests', models.JSONField(blank=True, null=True)),
                ('photo_url', models.URLField(blank=True, max_length=500, null=True)),
            ],
        ),
    ]
