using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using static TextureDrawHelper;
public class cameraDrawer : MonoBehaviour
{
    private Camera cam;
    public GameObject cursor;
    private float radius = 25;

    [Range(0.1f, 5f)]
    public float scale = 0.5f;

    [Range(100, 300)]
    public int cursorSizeOffset = 250;

    void Start()
    {
        cam = GetComponent<Camera>();
    }

    void Update()
    {
        //User can update the radius of the brush.
        radius += Input.mouseScrollDelta.y * scale;

        RaycastHit hit;
        if (!Physics.Raycast(cam.ScreenPointToRay(Input.mousePosition), out hit))
            return;

        UpdateCursorTransform(hit);

        if (!Input.GetMouseButton(0) && !Input.GetMouseButton(1))
            return;

        DrawOnSurfaceOfRaycastTarget(hit);
    }

    private void DrawOnSurfaceOfRaycastTarget(RaycastHit hit)
    {
        Color color = Input.GetMouseButton(0) ? Color.white : Color.black;
        TextureDrawHelper.DrawCircleAtPoint(hit, color, radius);
    }

    void UpdateCursorTransform(RaycastHit hit)
    {
        cursor.transform.position = hit.point;
        cursor.transform.localScale = new Vector3(radius / 250, radius / 250, radius / 250);
    }

}
