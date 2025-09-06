from pptx import Presentation

# Créer une nouvelle présentation
presentation = Presentation()

# Ajouter une diapositive de titre
slide_1 = presentation.slides.add_slide(presentation.slide_layouts[0])
title_1 = slide_1.shapes.title
subtitle_1 = slide_1.placeholders[1]
title_1.text = "CV Ahmet Basbunar"
subtitle_1.text = "En recherche de stage\nContact:\nTéléphone : +33 07 83 05 60 17\nEmail : a.basbunar1@gmail.com\nLocalisation : Metz, 57000"

# Ajouter une diapositive de formation
slide_2 = presentation.slides.add_slide(presentation.slide_layouts[1])
title_2 = slide_2.shapes.title
content_2 = slide_2.shapes.placeholders[1].text_frame
title_2.text = "Formation"
content_2.text = "• IUT de Metz, Université de Lorraine (2024 - 2025)\n  - BUT Informatique, 1ère Année\n"
content_2.add_paragraph("• Lycée de la Communication, Metz (2022 - 2024)\n  - Bac Technologique STI2D, option SIN")
content_2.add_paragraph("• Lycée Félix Mayer, Creutzwald (2021 - 2022)\n  - 2nde Générale, option SNT")
content_2.add_paragraph("• Collège Adalbert, Bouzonville (2017 - 2021)\n  - Diplôme National du Brevet")

# Ajouter une diapositive de compétences
slide_3 = presentation.slides.add_slide(presentation.slide_layouts[1])
title_3 = slide_3.shapes.title
content_3 = slide_3.shapes.placeholders[1].text_frame
title_3.text = "Compétences"
content_3.text = "• Programmation : HTML-CSS, Java, JavaScript, C, C++, Python, SQL"
content_3.add_paragraph("• Gestion de projets en équipe")
content_3.add_paragraph("• Création de bases de données")
content_3.add_paragraph("• Conception de circuits avec Arduino")

# Ajouter une diapositive d'expériences
slide_4 = presentation.slides.add_slide(presentation.slide_layouts[1])
title_4 = slide_4.shapes.title
content_4 = slide_4.shapes.placeholders[1].text_frame
title_4.text = "Expériences"
content_4.text = "• Stage de 3ème (2021) chez Construction Basbunar"

# Ajouter une diapositive de langues
slide_5 = presentation.slides.add_slide(presentation.slide_layouts[1])
title_5 = slide_5.shapes.title
content_5 = slide_5.shapes.placeholders[1].text_frame
title_5.text = "Langues"
content_5.text = "• Français (langue maternelle)"
content_5.add_paragraph("• Turc (langue maternelle)")
content_5.add_paragraph("• Anglais (niveau B2)")

# Ajouter une diapositive de centres d'intérêt
slide_6 = presentation.slides.add_slide(presentation.slide_layouts[1])
title_6 = slide_6.shapes.title
content_6 = slide_6.shapes.placeholders[1].text_frame
title_6.text = "Centres d'intérêt"
content_6.text = "• Photographie\n• Musique\n• Sports :"
content_6.add_paragraph("  - Handball (Bouzonville Handball)")
content_6.add_paragraph("  - Judo (Judo Club Bouzonville)")

# Ajouter une diapositive de qualités
slide_7 = presentation.slides.add_slide(presentation.slide_layouts[1])
title_7 = slide_7.shapes.title
content_7 = slide_7.shapes.placeholders[1].text_frame
title_7.text = "Qualités"
content_7.text = "• Esprit d’équipe\n• Autonomie\n• Dynamique\n• Adaptabilité\n• Polyvalence"

# Sauvegarder la présentation
presentation.save("Presentation_CV_Ahmet_Basbunar.pptx")

print("La présentation a été créée avec succès.")
