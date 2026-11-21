syms Mx My Mz p q r ...
    Ixx Iyy Izz Ixy Ixz Iyz Iyx Izx Izy ...
    pq qr pr psquare qsquare rsquare

p_dot = ...
    ((Iyy*Izz - Iyz*Izy)/(Ixx*Iyy*Izz - Ixx*Iyz*Izy - Ixy*Iyx*Izz + Ixy*Iyz*Izx + Ixz*Iyx*Izy - Ixz*Iyy*Izx))*Mx + (-(Ixy*Izz - Ixz*Izy)/(Ixx*Iyy*Izz - Ixx*Iyz*Izy - Ixy*Iyx*Izz + Ixy*Iyz*Izx + Ixz*Iyx*Izy - Ixz*Iyy*Izx))*My + ((Ixy*Iyz - Ixz*Iyy)/(Ixx*Iyy*Izz - Ixx*Iyz*Izy - Ixy*Iyx*Izz + Ixy*Iyz*Izx + Ixz*Iyx*Izy - Ixz*Iyy*Izx))*Mz + (-(Ixy*Iyx*Iyz - Ixz*Iyx*Iyy + Ixy*Izx*Izz - Ixz*Izx*Izy)/(Ixx*Iyy*Izz - Ixx*Iyz*Izy - Ixy*Iyx*Izz + Ixy*Iyz*Izx + Ixz*Iyx*Izy - Ixz*Iyy*Izx))*psquare + ((Iyz*Ixy^2 - Ixz*Iyy*Ixy + Iyz*Izy^2 - Iyy*Izz*Izy)/(Ixx*Iyy*Izz - Ixx*Iyz*Izy - Ixy*Iyx*Izz + Ixy*Iyz*Izx + Ixz*Iyx*Izy - Ixz*Iyy*Izx))*qsquare + (-(Izy*Ixz^2 - Ixy*Izz*Ixz + Izy*Iyz^2 - Iyy*Izz*Iyz)/(Ixx*Iyy*Izz - Ixx*Iyz*Izy - Ixy*Iyx*Izz + Ixy*Iyz*Izx + Ixz*Iyx*Izy - Ixz*Iyy*Izx))*rsquare + (Ixz*Iyy^2*pq + Ixz*Izy^2*pq - Ixy*Iyz^2*pr - Ixy*Izz^2*pr - Ixz^2*Iyy*qr + Ixy^2*Izz*qr - Iyy*Izz^2*qr + Iyy^2*Izz*qr + Ixx*Ixy*Iyz*pq - Ixx*Ixz*Iyy*pq - Ixy*Iyy*Iyz*pq - Ixy*Izy*Izz*pq - Iyy*Izx*Izz*pq + Iyz*Izx*Izy*pq + Ixx*Ixy*Izz*pr - Ixx*Ixz*Izy*pr + Ixz*Iyy*Iyz*pr + Iyx*Iyy*Izz*pr - Iyx*Iyz*Izy*pr + Ixz*Izy*Izz*pr + Ixy*Ixz*Iyz*qr - Ixy*Ixz*Izy*qr - Iyy*Iyz*Izy*qr + Iyz*Izy*Izz*qr)/(Ixx*Iyy*Izz - Ixx*Iyz*Izy - Ixy*Iyx*Izz + Ixy*Iyz*Izx + Ixz*Iyx*Izy - Ixz*Iyy*Izx);
        
         
q_dot = ...
    (-(Iyx*Izz - Iyz*Izx)/(Ixx*Iyy*Izz - Ixx*Iyz*Izy - Ixy*Iyx*Izz + Ixy*Iyz*Izx + Ixz*Iyx*Izy - Ixz*Iyy*Izx))*Mx + ((Ixx*Izz - Ixz*Izx)/(Ixx*Iyy*Izz - Ixx*Iyz*Izy - Ixy*Iyx*Izz + Ixy*Iyz*Izx + Ixz*Iyx*Izy - Ixz*Iyy*Izx))*My + (-(Ixx*Iyz - Ixz*Iyx)/(Ixx*Iyy*Izz - Ixx*Iyz*Izy - Ixy*Iyx*Izz + Ixy*Iyz*Izx + Ixz*Iyx*Izy - Ixz*Iyy*Izx))*Mz + (-(Ixz*Iyx^2 - Ixx*Iyz*Iyx + Ixz*Izx^2 - Ixx*Izz*Izx)/(Ixx*Iyy*Izz - Ixx*Iyz*Izy - Ixy*Iyx*Izz + Ixy*Iyz*Izx + Ixz*Iyx*Izy - Ixz*Iyy*Izx))*psquare + (-(Ixx*Ixy*Iyz - Ixy*Ixz*Iyx - Iyx*Izy*Izz + Iyz*Izx*Izy)/(Ixx*Iyy*Izz - Ixx*Iyz*Izy - Ixy*Iyx*Izz + Ixy*Iyz*Izx + Ixz*Iyx*Izy - Ixz*Iyy*Izx))*qsquare + ((Izx*Ixz^2 - Ixx*Izz*Ixz + Izx*Iyz^2 - Iyx*Izz*Iyz)/(Ixx*Iyy*Izz - Ixx*Iyz*Izy - Ixy*Iyx*Izz + Ixy*Iyz*Izx + Ixz*Iyx*Izy - Ixz*Iyy*Izx))*rsquare - (Ixx^2*Iyz*pq + Iyz*Izx^2*pq - Ixx*Iyz^2*pr - Ixx*Izz^2*pr + Ixx^2*Izz*pr + Iyx^2*Izz*pr - Ixz^2*Iyx*qr - Iyx*Izz^2*qr - Ixx*Ixz*Iyx*pq - Ixx*Iyy*Iyz*pq + Ixz*Iyx*Iyy*pq - Ixx*Izy*Izz*pq + Ixz*Izx*Izy*pq - Iyx*Izx*Izz*pq - Ixx*Ixz*Izx*pr + Ixz*Iyx*Iyz*pr - Iyx*Iyz*Izx*pr + Ixz*Izx*Izz*pr + Ixx*Ixz*Iyz*qr + Ixx*Ixy*Izz*qr - Ixy*Ixz*Izx*qr + Iyx*Iyy*Izz*qr - Iyy*Iyz*Izx*qr + Iyz*Izx*Izz*qr)/(Ixx*Iyy*Izz - Ixx*Iyz*Izy - Ixy*Iyx*Izz + Ixy*Iyz*Izx + Ixz*Iyx*Izy - Ixz*Iyy*Izx);
        
         
r_dot = ...
    ((Iyx*Izy - Iyy*Izx)/(Ixx*Iyy*Izz - Ixx*Iyz*Izy - Ixy*Iyx*Izz + Ixy*Iyz*Izx + Ixz*Iyx*Izy - Ixz*Iyy*Izx))*Mx + (-(Ixx*Izy - Ixy*Izx)/(Ixx*Iyy*Izz - Ixx*Iyz*Izy - Ixy*Iyx*Izz + Ixy*Iyz*Izx + Ixz*Iyx*Izy - Ixz*Iyy*Izx))*My + ((Ixx*Iyy - Ixy*Iyx)/(Ixx*Iyy*Izz - Ixx*Iyz*Izy - Ixy*Iyx*Izz + Ixy*Iyz*Izx + Ixz*Iyx*Izy - Ixz*Iyy*Izx))*Mz + ((Ixy*Iyx^2 - Ixx*Iyy*Iyx + Ixy*Izx^2 - Ixx*Izy*Izx)/(Ixx*Iyy*Izz - Ixx*Iyz*Izy - Ixy*Iyx*Izz + Ixy*Iyz*Izx + Ixz*Iyx*Izy - Ixz*Iyy*Izx))*psquare + (-(Iyx*Ixy^2 - Ixx*Iyy*Ixy + Iyx*Izy^2 - Iyy*Izx*Izy)/(Ixx*Iyy*Izz - Ixx*Iyz*Izy - Ixy*Iyx*Izz + Ixy*Iyz*Izx + Ixz*Iyx*Izy - Ixz*Iyy*Izx))*qsquare + ((Ixx*Ixz*Izy - Ixy*Ixz*Izx + Iyx*Iyz*Izy - Iyy*Iyz*Izx)/(Ixx*Iyy*Izz - Ixx*Iyz*Izy - Ixy*Iyx*Izz + Ixy*Iyz*Izx + Ixz*Iyx*Izy - Ixz*Iyy*Izx))*rsquare - (Ixx*Iyy^2*pq - Ixx^2*Iyy*pq + Ixx*Izy^2*pq - Iyy*Izx^2*pq - Ixx^2*Izy*pr - Iyx^2*Izy*pr + Ixy^2*Izx*qr + Iyy^2*Izx*qr + Ixx*Ixy*Iyx*pq - Ixy*Iyx*Iyy*pq - Ixy*Izx*Izy*pq + Iyx*Izx*Izy*pq + Ixx*Ixy*Izx*pr + Ixx*Iyy*Iyz*pr - Ixy*Iyx*Iyz*pr + Iyx*Iyy*Izx*pr + Ixx*Izy*Izz*pr - Ixy*Izx*Izz*pr - Ixx*Ixz*Iyy*qr + Ixy*Ixz*Iyx*qr - Ixx*Ixy*Izy*qr - Iyx*Iyy*Izy*qr + Iyx*Izy*Izz*qr - Iyy*Izx*Izz*qr)/(Ixx*Iyy*Izz - Ixx*Iyz*Izy - Ixy*Iyx*Izz + Ixy*Iyz*Izx + Ixz*Iyx*Izy - Ixz*Iyy*Izx);

items = [Mx, My, Mz, psquare, qsquare, rsquare, pq, qr, pr];

p_dot_collected = collect(p_dot, items);
q_dot_collected = collect(q_dot, items);
r_dot_collected = collect(r_dot, items);
        
        