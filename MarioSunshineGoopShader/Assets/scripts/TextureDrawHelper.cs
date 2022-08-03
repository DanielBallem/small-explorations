using UnityEngine;

public static class TextureDrawHelper
{
    public static Texture2D DrawCircle(this Texture2D tex, Color color, int x, int y, int radius)
    {
        float rSquared = radius * radius;

        for (int u = x - radius; u < x + radius + 1; u++)
            for (int v = y - radius; v < y + radius + 1; v++)
                if ((x - u) * (x - u) + (y - v) * (y - v) < rSquared)
                    tex.SetPixel(u, v, color);

        return tex;
    }

    public static void DrawCircleAtPoint(RaycastHit hit, Color color, float radius = 25)
    {
        Renderer rend = hit.transform.GetComponent<Renderer>();
        MeshCollider meshCollider = hit.collider as MeshCollider;

        if (rend == null || rend.sharedMaterial == null || rend.sharedMaterial.mainTexture == null || meshCollider == null)
            return;

        Texture2D tex = rend.material.mainTexture as Texture2D;
        Vector2 pixelUV = hit.textureCoord;
        pixelUV.x *= tex.width;
        pixelUV.y *= tex.height;

        tex = TextureDrawHelper.DrawCircle(tex, color, (int)pixelUV.x, (int)pixelUV.y, (int)radius);
        tex.Apply();
    }
}
