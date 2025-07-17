#!/usr/bin/env python3
"""
Replace App Icon Script
Usage: python3 replace_app_icon.py <path_to_your_icon_image>
"""

import os
import sys
import json
from PIL import Image

def generate_app_icons(source_image_path, output_dir):
    """Generate all required app icon sizes from a source image."""
    
    # Icon sizes based on Contents.json
    icon_sizes = [
        # iPhone
        ("20x20", "2x", "iphone", 40),    # 20@2x
        ("20x20", "3x", "iphone", 60),    # 20@3x
        ("29x29", "2x", "iphone", 58),    # 29@2x
        ("29x29", "3x", "iphone", 87),    # 29@3x
        ("40x40", "2x", "iphone", 80),    # 40@2x
        ("40x40", "3x", "iphone", 120),   # 40@3x
        ("60x60", "2x", "iphone", 120),   # 60@2x
        ("60x60", "3x", "iphone", 180),   # 60@3x
        
        # iPad
        ("20x20", "1x", "ipad", 20),      # 20@1x
        ("20x20", "2x", "ipad", 40),      # 20@2x
        ("29x29", "1x", "ipad", 29),      # 29@1x
        ("29x29", "2x", "ipad", 58),      # 29@2x
        ("40x40", "1x", "ipad", 40),      # 40@1x
        ("40x40", "2x", "ipad", 80),      # 40@2x
        ("76x76", "2x", "ipad", 152),     # 76@2x
        ("83.5x83.5", "2x", "ipad", 167), # 83.5@2x
        
        # App Store
        ("1024x1024", "1x", "ios-marketing", 1024),  # 1024@1x
    ]
    
    # Open source image
    try:
        with Image.open(source_image_path) as img:
            # Convert to RGB if necessary
            if img.mode != 'RGB':
                img = img.convert('RGB')
            
            # Generate each icon size
            for size_name, scale, idiom, pixel_size in icon_sizes:
                # Create filename
                if scale == "1x":
                    filename = f"icon_{size_name.replace('x', '_')}.png"
                else:
                    filename = f"icon_{size_name.replace('x', '_')}@{scale}.png"
                
                # Resize image
                resized = img.resize((pixel_size, pixel_size), Image.Resampling.LANCZOS)
                
                # Save
                output_path = os.path.join(output_dir, filename)
                resized.save(output_path, 'PNG')
                print(f"Generated: {filename} ({pixel_size}x{pixel_size})")
    
    except Exception as e:
        print(f"Error processing image: {e}")
        return False
    
    return True

def main():
    if len(sys.argv) != 2:
        print("Usage: python3 replace_app_icon.py <path_to_your_icon_image>")
        print("Example: python3 replace_app_icon.py my_custom_icon.png")
        sys.exit(1)
    
    source_image = sys.argv[1]
    output_dir = "MySwiftUIApp/Assets.xcassets/AppIcon.appiconset/"
    
    if not os.path.exists(source_image):
        print(f"Error: Source image '{source_image}' not found")
        sys.exit(1)
    
    if not os.path.exists(output_dir):
        print(f"Error: Output directory '{output_dir}' not found")
        sys.exit(1)
    
    print(f"Replacing app icon with: {source_image}")
    print(f"Output directory: {output_dir}")
    
    # Generate icons
    if generate_app_icons(source_image, output_dir):
        print(f"\n✅ Successfully updated app icon!")
        print("The new icon will be visible when you build and run the app.")
    else:
        print("❌ Failed to update app icon")
        sys.exit(1)

if __name__ == "__main__":
    main()
